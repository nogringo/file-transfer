// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'File Transfer';

  @override
  String get connectToNostr => 'Connect to Nostr';

  @override
  String get login => 'Login';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get current => 'Current';

  @override
  String get addAccount => 'Add account';

  @override
  String get logout => 'Logout';

  @override
  String get dragDropFile => 'Drag & drop a file or select to share';

  @override
  String get selectFile => 'Select File';

  @override
  String get uploading => 'Uploading...';

  @override
  String get pasteShareLink => 'Paste Share Link';

  @override
  String get dropFileToUpload => 'Drop file to upload';

  @override
  String get fileReadyToUpload => 'File Ready to Upload';

  @override
  String get fileSelected => 'File selected';

  @override
  String get uploadFile => 'Upload File';

  @override
  String get selectDifferentFile => 'Select Different File';

  @override
  String get name => 'Name:';

  @override
  String get size => 'Size:';

  @override
  String get type => 'Type:';

  @override
  String get modified => 'Modified:';

  @override
  String get unknown => 'Unknown';

  @override
  String get shareLinkReady => 'Share Link Ready';

  @override
  String get fileReadyToShare => 'File ready to share!';

  @override
  String get copyShareLink => 'Copy Share Link';

  @override
  String get shareAnotherFile => 'Share Another File';

  @override
  String get shareLink => 'Share Link:';

  @override
  String get eventNevent => 'Event (nevent):';

  @override
  String get privateKeyNsec => 'Private Key (nsec):';

  @override
  String get downloadFile => 'Download File';

  @override
  String get fetchingMetadata => 'Fetching file metadata...';

  @override
  String get fileReadyToDownload => 'File Ready to Download';

  @override
  String get download => 'Download';

  @override
  String get downloading => 'Downloading...';

  @override
  String get fileDownloadedSuccess => 'File downloaded successfully!';

  @override
  String get fileSaved => 'File saved';

  @override
  String failedToSave(Object error) {
    return 'Failed to save: $error';
  }

  @override
  String get unableToReadFile => 'Unable to read file data';

  @override
  String get noFileSelected => 'No file selected';

  @override
  String get shareLinkCopied => 'Share link copied to clipboard';

  @override
  String get noLinkFound => 'No link found in clipboard';

  @override
  String get invalidShareLink => 'Invalid share link format';

  @override
  String get selectFileTitle => 'Select File';
}
