import 'package:url_launcher/url_launcher.dart';

Future<void> onLaunchBrowser(String url) async {
  try {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  } catch (_) {}
}

Future<void> onLaunchPhone(String phone) async {
  if (!await launchUrl(Uri.parse('tel:$phone'))) {
    throw Exception('Could not launch tel:$phone');
  }
}
