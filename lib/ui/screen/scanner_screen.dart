import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_vision/qr_code_vision.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  static String get routeName => "/ScannerScreen";

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController cameraController;
  bool isScanned = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // 💡 جلوگیری از روشن شدن و درخواست مجوز وب‌کم در اکستنشن کروم
    cameraController = MobileScannerController(autoStart: !kIsWeb);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  // متد استخراج بارکد از عکس (مشترک برای موبایل و وب)
  Future<void> _scanFromGallery(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      String? extractedCode;

      if (kIsWeb) {
        //  پردازش ۱۰۰٪ آفلاین و Pure Dart برای اکستنشن کروم
        final bytes = await image.readAsBytes();
        final decodedImage = img.decodeImage(bytes);

        if (decodedImage != null) {
          final qrCode = QrCode();

          qrCode.scanRgbaBytes(
            decodedImage.getBytes(),
            decodedImage.width,
            decodedImage.height,
          );

          extractedCode = qrCode.content?.text;
        }
      } else {
        //  پردازش بومی مخصوص موبایل با سرعت بالای ML Kit
        final BarcodeCapture? capture = await cameraController.analyzeImage(
          image.path,
        );

        if (capture != null && capture.barcodes.isNotEmpty) {
          for (final barcode in capture.barcodes) {
            if (barcode.rawValue != null) {
              extractedCode = barcode.rawValue;
              break;
            }
          }
        }
      }

      // بررسی نتیجه نهایی
      if (extractedCode != null && !isScanned) {
        isScanned = true;
        debugPrint('📸 بارکد استخراج شد: $extractedCode');

        if (context.mounted) {
          Navigator.of(context).pop(extractedCode);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: MyColors.salmon,
              duration: const Duration(seconds: 2),
              content: Text(l10n.snackBar),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error scanning image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (kIsWeb) {
      return _buildWebUI(context, l10n, isDarkMode);
    } else {
      return _buildMobileUI(context, l10n);
    }
  }


  Widget _buildWebUI(
    BuildContext context,
    AppLocalizations l10n,
    bool isDarkMode,
  ) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subTextColor = isDarkMode
        ? Colors.grey.shade400
        : Colors.grey.shade700;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: MyColors.salmon.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.qr_code_2,
                  size: 64,
                  color: MyColors.salmon,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                l10n.webScanTitle,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cr",
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.webScanSubTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 14,
                  fontFamily: "Cr",
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () => _scanFromGallery(context, l10n),
                  icon: const Icon(Icons.upload_file),
                  label: Text(
                    l10n.webScanTitleButton,
                    style: const TextStyle(
                      fontFamily: "Cr",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.salmon,
                    foregroundColor: Colors
                        .white, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildMobileUI(BuildContext context, AppLocalizations l10n) {
    final scanWindowSize = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
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
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.7),
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
                Center(
                  child: Container(
                    height: scanWindowSize,
                    width: scanWindowSize,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gallery Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 32,
                    icon: const Icon(Icons.image, color: Colors.white),
                    tooltip: 'انتخاب از گالری',
                    onPressed: () => _scanFromGallery(context, l10n),
                  ),
                ),
                const SizedBox(width: 40),
                // Flashlight Button
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
