// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Dateiübertragung';

  @override
  String get connectToNostr => 'Mit Nostr verbinden';

  @override
  String get login => 'Anmelden';

  @override
  String get anonymous => 'Anonym';

  @override
  String get current => 'Aktuell';

  @override
  String get addAccount => 'Konto hinzufügen';

  @override
  String get logout => 'Abmelden';

  @override
  String get dragDropFile => 'Datei ziehen & ablegen oder auswählen zum Teilen';

  @override
  String get selectFile => 'Datei auswählen';

  @override
  String get uploading => 'Wird hochgeladen...';

  @override
  String get pasteShareLink => 'Freigabelink einfügen';

  @override
  String get dropFileToUpload => 'Datei ablegen zum Hochladen';

  @override
  String get fileReadyToUpload => 'Datei bereit zum Hochladen';

  @override
  String get fileSelected => 'Datei ausgewählt';

  @override
  String get uploadFile => 'Datei hochladen';

  @override
  String get selectDifferentFile => 'Andere Datei auswählen';

  @override
  String get name => 'Name:';

  @override
  String get size => 'Größe:';

  @override
  String get type => 'Typ:';

  @override
  String get modified => 'Geändert:';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get shareLinkReady => 'Freigabelink bereit';

  @override
  String get fileReadyToShare => 'Datei bereit zum Teilen!';

  @override
  String get copyShareLink => 'Freigabelink kopieren';

  @override
  String get shareAnotherFile => 'Weitere Datei teilen';

  @override
  String get shareLink => 'Freigabelink:';

  @override
  String get eventNevent => 'Ereignis (nevent):';

  @override
  String get privateKeyNsec => 'Privater Schlüssel (nsec):';

  @override
  String get downloadFile => 'Datei herunterladen';

  @override
  String get fetchingMetadata => 'Metadaten werden abgerufen...';

  @override
  String get fileReadyToDownload => 'Datei bereit zum Herunterladen';

  @override
  String get download => 'Herunterladen';

  @override
  String get downloading => 'Wird heruntergeladen...';

  @override
  String get fileDownloadedSuccess => 'Datei erfolgreich heruntergeladen!';

  @override
  String get fileSaved => 'Datei gespeichert';

  @override
  String failedToSave(Object error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get unableToReadFile => 'Dateidaten können nicht gelesen werden';

  @override
  String get noFileSelected => 'Keine Datei ausgewählt';

  @override
  String get shareLinkCopied => 'Freigabelink in die Zwischenablage kopiert';

  @override
  String get noLinkFound => 'Kein Link in der Zwischenablage gefunden';

  @override
  String get invalidShareLink => 'Ungültiges Format des Freigabelinks';

  @override
  String get selectFileTitle => 'Datei auswählen';
}
