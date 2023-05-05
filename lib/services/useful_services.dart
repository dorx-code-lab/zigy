import 'package:url_launcher/url_launcher.dart';

class UserfulServices {
  launchTheThing(String uri) {
    launchUrl(
      Uri.parse(uri),
      mode: LaunchMode.externalApplication,
    );
  }
}
