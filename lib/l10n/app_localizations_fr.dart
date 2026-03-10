// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Transfert de Fichier';

  @override
  String get connectToNostr => 'Se connecter à Nostr';

  @override
  String get login => 'Connexion';

  @override
  String get anonymous => 'Anonyme';

  @override
  String get current => 'Actuel';

  @override
  String get addAccount => 'Ajouter un compte';

  @override
  String get logout => 'Déconnexion';

  @override
  String get dragDropFile =>
      'Glissez-déposez un fichier ou sélectionnez pour partager';

  @override
  String get selectFile => 'Sélectionner un fichier';

  @override
  String get uploading => 'Téléchargement...';

  @override
  String get pasteShareLink => 'Coller le lien de partage';

  @override
  String get dropFileToUpload => 'Déposez le fichier à télécharger';

  @override
  String get fileReadyToUpload => 'Fichier prêt à télécharger';

  @override
  String get fileSelected => 'Fichier sélectionné';

  @override
  String get uploadFile => 'Télécharger le fichier';

  @override
  String get selectDifferentFile => 'Sélectionner un autre fichier';

  @override
  String get name => 'Nom :';

  @override
  String get size => 'Taille :';

  @override
  String get type => 'Type :';

  @override
  String get modified => 'Modifié :';

  @override
  String get unknown => 'Inconnu';

  @override
  String get shareLinkReady => 'Lien de partage prêt';

  @override
  String get fileReadyToShare => 'Fichier prêt à partager !';

  @override
  String get copyShareLink => 'Copier le lien de partage';

  @override
  String get shareAnotherFile => 'Partager un autre fichier';

  @override
  String get shareLink => 'Lien de partage :';

  @override
  String get eventNevent => 'Événement (nevent) :';

  @override
  String get privateKeyNsec => 'Clé privée (nsec) :';

  @override
  String get downloadFile => 'Télécharger le fichier';

  @override
  String get fetchingMetadata => 'Récupération des métadonnées...';

  @override
  String get fileReadyToDownload => 'Fichier prêt à télécharger';

  @override
  String get download => 'Télécharger';

  @override
  String get downloading => 'Téléchargement...';

  @override
  String get fileDownloadedSuccess => 'Fichier téléchargé avec succès !';

  @override
  String get fileSaved => 'Fichier enregistré';

  @override
  String failedToSave(Object error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get unableToReadFile => 'Impossible de lire les données du fichier';

  @override
  String get noFileSelected => 'Aucun fichier sélectionné';

  @override
  String get shareLinkCopied => 'Lien de partage copié dans le presse-papiers';

  @override
  String get noLinkFound => 'Aucun lien trouvé dans le presse-papiers';

  @override
  String get invalidShareLink => 'Format de lien de partage invalide';

  @override
  String get selectFileTitle => 'Sélectionner un fichier';
}
