import 'dart:typed_data';

import 'package:file_transfer_sdk/src/functions/fetch_blob.dart';
import 'package:file_transfer_sdk/src/functions/fetch_file_metdata.dart';
import 'package:file_transfer_sdk/src/functions/share_file.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:test/test.dart';

void main() {
  test("First test", () async {
    final ndk = Ndk(
      NdkConfig(eventVerifier: Bip340EventVerifier(), cache: MemCacheManager()),
    );

    final keyPair = Bip340.generatePrivateKey();

    ndk.accounts.loginPrivateKey(
      pubkey: keyPair.publicKey,
      privkey: keyPair.privateKey!,
    );

    final originalData = Uint8List.fromList('Hello, World!'.codeUnits);

    final share = await shareFile(ndk: ndk, bytes: originalData);
    final fileMetadata = await fetchFileMetadata(ndk: ndk, sharedFile: share);
    final fetchedData = await fetchBlob(ndk: ndk, fileMetadata: fileMetadata);

    expect(fetchedData, originalData);
  });
}
