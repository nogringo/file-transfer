class AppRoutes {
  static const home = '/';
  static const fileShare = '/f/:nevent/:encodedPrivateKey';

  static String fileShareRoute(String nevent, String encodedPrivateKey) {
    return fileShare
        .replaceFirst(':nevent', nevent)
        .replaceFirst(':encodedPrivateKey', encodedPrivateKey);
  }
}
