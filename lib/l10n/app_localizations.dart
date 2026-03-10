import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'File Transfer'**
  String get appTitle;

  /// Login page title
  ///
  /// In en, this message translates to:
  /// **'Connect to Nostr'**
  String get connectToNostr;

  /// Login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Anonymous account label
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// Current account label
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// Add account button
  ///
  /// In en, this message translates to:
  /// **'Add account'**
  String get addAccount;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Upload instruction text
  ///
  /// In en, this message translates to:
  /// **'Drag & drop a file or select to share'**
  String get dragDropFile;

  /// Select file button
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get selectFile;

  /// Uploading status
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// Paste link button
  ///
  /// In en, this message translates to:
  /// **'Paste Share Link'**
  String get pasteShareLink;

  /// Drop zone text
  ///
  /// In en, this message translates to:
  /// **'Drop file to upload'**
  String get dropFileToUpload;

  /// File info page title
  ///
  /// In en, this message translates to:
  /// **'File Ready to Upload'**
  String get fileReadyToUpload;

  /// File selected status
  ///
  /// In en, this message translates to:
  /// **'File selected'**
  String get fileSelected;

  /// Upload file button
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get uploadFile;

  /// Select different file button
  ///
  /// In en, this message translates to:
  /// **'Select Different File'**
  String get selectDifferentFile;

  /// File name label
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get name;

  /// File size label
  ///
  /// In en, this message translates to:
  /// **'Size:'**
  String get size;

  /// File type label
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get type;

  /// Modified date label
  ///
  /// In en, this message translates to:
  /// **'Modified:'**
  String get modified;

  /// Unknown file type
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Share link page title
  ///
  /// In en, this message translates to:
  /// **'Share Link Ready'**
  String get shareLinkReady;

  /// File ready status
  ///
  /// In en, this message translates to:
  /// **'File ready to share!'**
  String get fileReadyToShare;

  /// Copy link button
  ///
  /// In en, this message translates to:
  /// **'Copy Share Link'**
  String get copyShareLink;

  /// Share another file button
  ///
  /// In en, this message translates to:
  /// **'Share Another File'**
  String get shareAnotherFile;

  /// Share link label
  ///
  /// In en, this message translates to:
  /// **'Share Link:'**
  String get shareLink;

  /// Nevent label
  ///
  /// In en, this message translates to:
  /// **'Event (nevent):'**
  String get eventNevent;

  /// Private key label
  ///
  /// In en, this message translates to:
  /// **'Private Key (nsec):'**
  String get privateKeyNsec;

  /// Download page title
  ///
  /// In en, this message translates to:
  /// **'Download File'**
  String get downloadFile;

  /// Loading metadata text
  ///
  /// In en, this message translates to:
  /// **'Fetching file metadata...'**
  String get fetchingMetadata;

  /// Download ready title
  ///
  /// In en, this message translates to:
  /// **'File Ready to Download'**
  String get fileReadyToDownload;

  /// Download button
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// Downloading status
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get downloading;

  /// Download success message
  ///
  /// In en, this message translates to:
  /// **'File downloaded successfully!'**
  String get fileDownloadedSuccess;

  /// File saved toast message
  ///
  /// In en, this message translates to:
  /// **'File saved'**
  String get fileSaved;

  /// Failed to save toast message
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String failedToSave(Object error);

  /// Error when file bytes cannot be read
  ///
  /// In en, this message translates to:
  /// **'Unable to read file data'**
  String get unableToReadFile;

  /// Error when no file is selected for upload
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// Toast message when share link is copied
  ///
  /// In en, this message translates to:
  /// **'Share link copied to clipboard'**
  String get shareLinkCopied;

  /// Toast message when no link is in clipboard
  ///
  /// In en, this message translates to:
  /// **'No link found in clipboard'**
  String get noLinkFound;

  /// Toast message when share link format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid share link format'**
  String get invalidShareLink;

  /// File picker dialog title
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get selectFileTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
