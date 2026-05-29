import 'package:url_launcher/url_launcher.dart';

Future<void> urlLauncher(String url) async {
  final Uri myUrl = Uri.parse(url);

  try {
    await launchUrl(myUrl, mode: LaunchMode.externalApplication);
  } catch (e) {
    throw "can not launch $url";
  }
}
