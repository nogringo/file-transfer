// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Transferencia de Archivos';

  @override
  String get connectToNostr => 'Conectar a Nostr';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get anonymous => 'Anónimo';

  @override
  String get current => 'Actual';

  @override
  String get addAccount => 'Añadir cuenta';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get dragDropFile =>
      'Arrastra y suelta un archivo o selecciona para compartir';

  @override
  String get selectFile => 'Seleccionar archivo';

  @override
  String get uploading => 'Subiendo...';

  @override
  String get pasteShareLink => 'Pegar enlace de compartir';

  @override
  String get dropFileToUpload => 'Suelta el archivo para subir';

  @override
  String get fileReadyToUpload => 'Archivo listo para subir';

  @override
  String get fileSelected => 'Archivo seleccionado';

  @override
  String get uploadFile => 'Subir archivo';

  @override
  String get selectDifferentFile => 'Seleccionar otro archivo';

  @override
  String get name => 'Nombre:';

  @override
  String get size => 'Tamaño:';

  @override
  String get type => 'Tipo:';

  @override
  String get modified => 'Modificado:';

  @override
  String get unknown => 'Desconocido';

  @override
  String get shareLinkReady => 'Enlace listo';

  @override
  String get fileReadyToShare => '¡Archivo listo para compartir!';

  @override
  String get copyShareLink => 'Copiar enlace';

  @override
  String get shareAnotherFile => 'Compartir otro archivo';

  @override
  String get shareLink => 'Enlace de compartir:';

  @override
  String get eventNevent => 'Evento (nevent):';

  @override
  String get privateKeyNsec => 'Clave privada (nsec):';

  @override
  String get downloadFile => 'Descargar archivo';

  @override
  String get fetchingMetadata => 'Obteniendo metadatos...';

  @override
  String get fileReadyToDownload => 'Archivo listo para descargar';

  @override
  String get download => 'Descargar';

  @override
  String get downloading => 'Descargando...';

  @override
  String get fileDownloadedSuccess => '¡Archivo descargado con éxito!';

  @override
  String get fileSaved => 'Archivo guardado';

  @override
  String failedToSave(Object error) {
    return 'Error al guardar: $error';
  }

  @override
  String get unableToReadFile => 'No se pudieron leer los datos del archivo';

  @override
  String get noFileSelected => 'Ningún archivo seleccionado';

  @override
  String get shareLinkCopied => 'Enlace copiado al portapapeles';

  @override
  String get noLinkFound => 'No se encontró ningún enlace en el portapapeles';

  @override
  String get invalidShareLink => 'Formato de enlace inválido';

  @override
  String get selectFileTitle => 'Seleccionar archivo';
}
