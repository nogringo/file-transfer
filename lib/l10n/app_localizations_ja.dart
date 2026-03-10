// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ファイル転送';

  @override
  String get connectToNostr => 'Nostr に接続';

  @override
  String get login => 'ログイン';

  @override
  String get anonymous => '匿名';

  @override
  String get current => '現在';

  @override
  String get addAccount => 'アカウントを追加';

  @override
  String get logout => 'ログアウト';

  @override
  String get dragDropFile => 'ファイルをドラッグ＆ドロップまたは選択して共有';

  @override
  String get selectFile => 'ファイルを選択';

  @override
  String get uploading => 'アップロード中...';

  @override
  String get pasteShareLink => '共有リンクを貼り付け';

  @override
  String get dropFileToUpload => 'ファイルをドロップしてアップロード';

  @override
  String get fileReadyToUpload => 'ファイルのアップロード準備完了';

  @override
  String get fileSelected => 'ファイルが選択されました';

  @override
  String get uploadFile => 'ファイルをアップロード';

  @override
  String get selectDifferentFile => '別のファイルを選択';

  @override
  String get name => '名前：';

  @override
  String get size => 'サイズ：';

  @override
  String get type => 'タイプ：';

  @override
  String get modified => '更新日：';

  @override
  String get unknown => '不明';

  @override
  String get shareLinkReady => '共有リンクの準備完了';

  @override
  String get fileReadyToShare => 'ファイルの共有準備完了！';

  @override
  String get copyShareLink => '共有リンクをコピー';

  @override
  String get shareAnotherFile => '別のファイルを共有';

  @override
  String get shareLink => '共有リンク：';

  @override
  String get eventNevent => 'イベント（nevent）：';

  @override
  String get privateKeyNsec => '秘密鍵（nsec）：';

  @override
  String get downloadFile => 'ファイルをダウンロード';

  @override
  String get fetchingMetadata => 'ファイルメタデータを取得中...';

  @override
  String get fileReadyToDownload => 'ファイルのダウンロード準備完了';

  @override
  String get download => 'ダウンロード';

  @override
  String get downloading => 'ダウンロード中...';

  @override
  String get fileDownloadedSuccess => 'ファイルが正常にダウンロードされました！';

  @override
  String get fileSaved => 'ファイルを保存しました';

  @override
  String failedToSave(Object error) {
    return '保存に失敗しました：$error';
  }

  @override
  String get unableToReadFile => 'ファイルデータを読み取れません';

  @override
  String get noFileSelected => 'ファイルが選択されていません';

  @override
  String get shareLinkCopied => '共有リンクをクリップボードにコピーしました';

  @override
  String get noLinkFound => 'クリップボードにリンクが見つかりません';

  @override
  String get invalidShareLink => '共有リンクの形式が無効です';

  @override
  String get selectFileTitle => 'ファイルを選択';
}
