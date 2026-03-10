// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '文件传输';

  @override
  String get connectToNostr => '连接到 Nostr';

  @override
  String get login => '登录';

  @override
  String get anonymous => '匿名';

  @override
  String get current => '当前';

  @override
  String get addAccount => '添加账户';

  @override
  String get logout => '登出';

  @override
  String get dragDropFile => '拖放文件或选择分享';

  @override
  String get selectFile => '选择文件';

  @override
  String get uploading => '上传中...';

  @override
  String get pasteShareLink => '粘贴分享链接';

  @override
  String get dropFileToUpload => '放下文件以上传';

  @override
  String get fileReadyToUpload => '文件已准备好上传';

  @override
  String get fileSelected => '文件已选择';

  @override
  String get uploadFile => '上传文件';

  @override
  String get selectDifferentFile => '选择其他文件';

  @override
  String get name => '名称：';

  @override
  String get size => '大小：';

  @override
  String get type => '类型：';

  @override
  String get modified => '修改时间：';

  @override
  String get unknown => '未知';

  @override
  String get shareLinkReady => '分享链接已准备好';

  @override
  String get fileReadyToShare => '文件已准备好分享！';

  @override
  String get copyShareLink => '复制分享链接';

  @override
  String get shareAnotherFile => '分享另一个文件';

  @override
  String get shareLink => '分享链接：';

  @override
  String get eventNevent => '事件（nevent）：';

  @override
  String get privateKeyNsec => '私钥（nsec）：';

  @override
  String get downloadFile => '下载文件';

  @override
  String get fetchingMetadata => '正在获取文件元数据...';

  @override
  String get fileReadyToDownload => '文件已准备好下载';

  @override
  String get download => '下载';

  @override
  String get downloading => '下载中...';

  @override
  String get fileDownloadedSuccess => '文件下载成功！';

  @override
  String get fileSaved => '文件已保存';

  @override
  String failedToSave(Object error) {
    return '保存失败：$error';
  }

  @override
  String get unableToReadFile => '无法读取文件数据';

  @override
  String get noFileSelected => '未选择文件';

  @override
  String get shareLinkCopied => '分享链接已复制到剪贴板';

  @override
  String get noLinkFound => '剪贴板中未找到链接';

  @override
  String get invalidShareLink => '分享链接格式无效';

  @override
  String get selectFileTitle => '选择文件';
}
