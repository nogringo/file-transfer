import 'package:file_transfer/routes.dart';
import 'package:get/get.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class AccountController extends GetxController {
  final ndk = Get.find<Ndk>();
  final ndkFlutter = Get.find<NdkFlutter>();
  final _anonymousPubkey = RxnString();
  final _isLoading = true.obs;
  final _hasRealAccount = false.obs;

  String? get anonymousPubkey => _anonymousPubkey.value;
  bool get isLoading => _isLoading.value;
  bool get isLoggedIn => ndk.accounts.getLoggedAccount() != null;
  String? get pubkey => ndk.accounts.getLoggedAccount()?.pubkey;
  bool get hasRealAccount => _hasRealAccount.value;

  @override
  void onInit() {
    super.onInit();
    _loadAccountStatus();
    _listenToAuthChanges();
  }

  /// Listen to NDK auth state changes to update UI automatically
  void _listenToAuthChanges() {
    ndk.accounts.authStateChanges.listen((account) {
      _updateState();
    });
  }

  void _updateState() {
    // Check if there's any account other than the anonymous one
    final accounts = ndk.accounts.accounts.values;
    _hasRealAccount.value = accounts.any(
      (a) => a.pubkey != _anonymousPubkey.value,
    );

    update();
  }

  Future<void> _loadAccountStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _anonymousPubkey.value = prefs.getString(anonymousPubkeyKey);
    _updateState();
    _isLoading.value = false;
  }

  /// Handle menu selection from account popup
  void handleMenuSelection(String? value) {
    if (value == 'add_account') {
      Get.toNamed(AppRoutes.login);
    } else if (value == 'logout') {
      handleLogout();
    } else if (value?.startsWith('switch_') == true) {
      final switchPubkey = value!.substring(7);
      handleSwitchAccount(switchPubkey);
    }
  }

  /// Handle logout action
  Future<void> handleLogout() async {
    // Logout the current active account
    ndk.accounts.logout();

    // Switch to another account if available
    final remainingAccounts = ndk.accounts.accounts.values;
    if (remainingAccounts.isNotEmpty) {
      final accountToSwitch = remainingAccounts.first;
      ndk.accounts.switchAccount(pubkey: accountToSwitch.pubkey);
    } else {
      // No accounts left, create a new anonymous account
      await _createAnonymousAccount();
    }

    await ndkFlutter.saveAccountsState();
    updateAuth();
  }

  /// Handle account switch
  Future<void> handleSwitchAccount(String pubkey) async {
    ndk.accounts.switchAccount(pubkey: pubkey);
    await ndkFlutter.saveAccountsState();
    updateAuth();
  }

  /// Create a new anonymous account
  Future<void> _createAnonymousAccount() async {
    final keyPair = Bip340.generatePrivateKey();
    ndk.accounts.loginPrivateKey(
      pubkey: keyPair.publicKey,
      privkey: keyPair.privateKey!,
    );
    await ndkFlutter.saveAccountsState();
    // Update the anonymous pubkey in preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(anonymousPubkeyKey, keyPair.publicKey);
    updateAuth();
  }

  void updateAuth() => update();
}
