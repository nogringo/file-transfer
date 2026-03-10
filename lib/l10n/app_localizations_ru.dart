// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Передача Файлов';

  @override
  String get connectToNostr => 'Подключиться к Nostr';

  @override
  String get login => 'Войти';

  @override
  String get anonymous => 'Анонимно';

  @override
  String get current => 'Текущий';

  @override
  String get addAccount => 'Добавить аккаунт';

  @override
  String get logout => 'Выйти';

  @override
  String get dragDropFile => 'Перетащите файл или выберите для отправки';

  @override
  String get selectFile => 'Выбрать файл';

  @override
  String get uploading => 'Загрузка...';

  @override
  String get pasteShareLink => 'Вставить ссылку';

  @override
  String get dropFileToUpload => 'Отпустите файл для загрузки';

  @override
  String get fileReadyToUpload => 'Файл готов к загрузке';

  @override
  String get fileSelected => 'Файл выбран';

  @override
  String get uploadFile => 'Загрузить файл';

  @override
  String get selectDifferentFile => 'Выбрать другой файл';

  @override
  String get name => 'Имя:';

  @override
  String get size => 'Размер:';

  @override
  String get type => 'Тип:';

  @override
  String get modified => 'Изменен:';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get shareLinkReady => 'Ссылка готова';

  @override
  String get fileReadyToShare => 'Файл готов к отправке!';

  @override
  String get copyShareLink => 'Копировать ссылку';

  @override
  String get shareAnotherFile => 'Отправить другой файл';

  @override
  String get shareLink => 'Ссылка:';

  @override
  String get eventNevent => 'Событие (nevent):';

  @override
  String get privateKeyNsec => 'Приватный ключ (nsec):';

  @override
  String get downloadFile => 'Скачать файл';

  @override
  String get fetchingMetadata => 'Получение метаданных...';

  @override
  String get fileReadyToDownload => 'Файл готов к скачиванию';

  @override
  String get download => 'Скачать';

  @override
  String get downloading => 'Скачивание...';

  @override
  String get fileDownloadedSuccess => 'Файл успешно скачан!';

  @override
  String get fileSaved => 'Файл сохранен';

  @override
  String failedToSave(Object error) {
    return 'Ошибка сохранения: $error';
  }

  @override
  String get unableToReadFile => 'Не удалось прочитать данные файла';

  @override
  String get noFileSelected => 'Файл не выбран';

  @override
  String get shareLinkCopied => 'Ссылка скопирована в буфер обмена';

  @override
  String get noLinkFound => 'Ссылка не найдена в буфере обмена';

  @override
  String get invalidShareLink => 'Неверный формат ссылки';

  @override
  String get selectFileTitle => 'Выбрать файл';
}
