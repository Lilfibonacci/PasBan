import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  static String get routeName => "/ScannerScreen";

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isScanned = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _scanFromGallery() async {
    try {
      // 1. انتخاب عکس از گالری
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return; // اگر کاربر عکسی انتخاب نکرد و برگشت

      // 2. استفاده از اسکنر برای پیدا کردن بارکد در عکس
      final BarcodeCapture? capture = await cameraController.analyzeImage(
        image.path,
      );

      if (capture != null && capture.barcodes.isNotEmpty) {
        // پیدا کردن اولین بارکدی که مقدار دارد
        for (final barcode in capture.barcodes) {
          if (barcode.rawValue != null && !isScanned) {
            isScanned = true;
            final String code = barcode.rawValue!;
            debugPrint('📸 بارکد از گالری خوانده شد: $code');

            // بستن صفحه و ارسال کد به صفحه اصلی
            if (mounted) {
              Navigator.of(context).pop(code);
            }
            break;
          }
        }
      } else {
        // اگر عکسی انتخاب شد اما هیچ QR کدی در آن نبود
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('هیچ بارکدی در این عکس پیدا نشد.')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error scanning gallery image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // گرفتن ابعاد صفحه برای محاسبه سایز کادر اسکن
    final scanWindowSize = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      backgroundColor: Colors.black,
      // استفاده از Stack برای قرار دادن لایه‌ها روی هم
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. لایه زیرین: دوربین تمام صفحه
          MobileScanner(
            fit: BoxFit.cover,
            controller: cameraController,
            onDetect: (BarcodeCapture capture) {
              if (isScanned) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  isScanned = true;
                  final String code = barcode.rawValue!;

                  debugPrint('🎉 بارکد خوانده شد: $code');
                  Navigator.of(context).pop(code);
                  break;
                }
              }
            },
          ),

          // 2. لایه رویی: Overlay نیمه شفاف با یک کادر خالی در وسط
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.7), // رنگ لایه تاریک
              BlendMode.srcOut,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                // حفره شفاف وسط صفحه
                Center(
                  child: Container(
                    height: scanWindowSize,
                    width: scanWindowSize,
                    decoration: BoxDecoration(
                      color: Colors.red, // رنگ مهم نیست، شفاف می‌شود
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. لبه‌های سفید (Border) دور کادر شفاف
          Center(
            child: Container(
              height: scanWindowSize,
              width: scanWindowSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.5),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // 4. دکمه بازگشت در بالا سمت چپ
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // 5. دکمه‌های کنترل (فلش و گالری) در پایین صفحه
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // دکمه گالری
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.image, color: Colors.white),
                    tooltip: 'انتخاب از گالری',
                    onPressed: _scanFromGallery,
                  ),
                ),
                const SizedBox(width: 40),
                // دکمه فلش
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 32,
                    icon: ValueListenableBuilder<MobileScannerState>(
                      valueListenable: cameraController,
                      builder: (context, state, child) {
                        switch (state.torchState) {
                          case TorchState.on:
                            return const Icon(
                              Icons.flash_on,
                              color: Colors.yellow,
                            );
                          case TorchState.off:
                          case TorchState.unavailable:
                          case TorchState.auto:
                            return const Icon(
                              Icons.flash_off,
                              color: Colors.white,
                            );
                        }
                      },
                    ),
                    onPressed: () => cameraController.toggleTorch(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
