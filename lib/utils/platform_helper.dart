import 'package:file_transfer/routes.dart';

class PlatformHelper {
  /// Base URL for share links.
  ///
  /// Change this to your deployment URL:
  /// - GitHub Pages: 'https://username.github.io/repo/#'
  /// - Firebase: 'https://app.web.app'
  /// - Vercel: 'https://app.vercel.app'
  /// - Netlify: 'https://app.netlify.app'
  static const baseUrl = 'https://nogringo.github.io/file-transfer/#';

  static String buildShareLink(String nevent, String encodedPrivateKey) {
    return '$baseUrl${AppRoutes.fileShareRoute(nevent, encodedPrivateKey)}';
  }
}
