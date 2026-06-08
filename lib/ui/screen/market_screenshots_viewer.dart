import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/ui/screen/about_screen.dart';
import 'package:flutter_authenticator/ui/screen/home_screen.dart';
import 'package:flutter_authenticator/ui/screen/loading_screen.dart';
import 'package:flutter_authenticator/ui/screen/scanner_screen.dart';
import 'package:flutter_authenticator/ui/screen/setup_key_screen.dart'; // صفحه اصلی پاس‌بان

class MarketScreenshotsViewer extends StatelessWidget {
  const MarketScreenshotsViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F11),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            _buildScreenshotPage(
              title: "",
              subtitle: "",
              device: Devices.android.samsungGalaxyA50,
              screen: const HomeScreen(),
            ),
            _buildScreenshotPage(
              title: "",
              subtitle: "",
              device: Devices.android.samsungGalaxyA50,
              screen: const Scaffold(
                backgroundColor: MyColors.black,
                body: LoadingScreen(),
              ),
            ),
            _buildScreenshotPage(
              title: "",
              subtitle: "",
              device: Devices.android.samsungGalaxyA50,
              screen: const Scaffold(
                backgroundColor: MyColors.black,
                body: AboutScreen(),
              ),
            ),
            _buildScreenshotPage(
              title: "",
              subtitle: "",
              device: Devices.android.samsungGalaxyA50,
              screen: const Scaffold(
                backgroundColor: MyColors.black,
                body: SetupScreen(),
              ),
            ),
            _buildScreenshotPage(
              title: "",
              subtitle: "",
              device: Devices.android.samsungGalaxyA50,
              screen: const Scaffold(
                backgroundColor: MyColors.black,
                body: ScannerScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenshotPage({
    required String title,
    required String subtitle,
    required DeviceInfo device,
    required Widget screen,
  }) {
    return Container(
      width: 340,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF16161A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Cr",
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontFamily: "Cr",
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DeviceFrame(
                device: device,
                isFrameVisible: true,
                orientation: Orientation.portrait,
                screen: screen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
