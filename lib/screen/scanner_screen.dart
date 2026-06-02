import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
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

  //method for scan image from gallery
  Future<void> _scanFromGallery(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final BarcodeCapture? capture = await cameraController.analyzeImage(
        image.path,
      );

      if (capture != null && capture.barcodes.isNotEmpty) {
        for (final barcode in capture.barcodes) {
          if (barcode.rawValue != null && !isScanned) {
            isScanned = true;
            final String code = barcode.rawValue!;
            debugPrint('📸 بارکد از گالری خوانده شد: $code');

            if (context.mounted) {
              Navigator.of(context).pop(code);
            }
            break;
          }
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
      debugPrint('Error scanning gallery image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final scanWindowSize = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      backgroundColor: MyColors.black,
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
