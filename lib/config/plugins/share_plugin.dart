import 'package:share_plus/share_plus.dart';

class SharePlugin {
  static void shareLink(String link, String subject) {
    final params = ShareParams(uri: Uri.parse(link));
    SharePlus.instance.share(params);
  }
}
