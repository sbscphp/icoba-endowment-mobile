import 'dart:developer';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:icoba_endowment_mobile/core/env/env.dart';

/// AES-CBC encryption/decryption + HTTP helper for the ICOBA encrypted API.
///
/// Dependencies (pubspec.yaml):
///   encrypt: ^5.0.3
///   http: ^1.2.1
///
/// ⚠️  Security note (mirrors the guide):
///   For a Flutter *mobile* app, storing these credentials in a Dart const is
///   acceptable (treat them as sensitive; use --dart-define or a secrets file
///   excluded from version control, not plain source).
///   For a Flutter *web* build, move crypto to a BFF/proxy — the compiled JS
///   bundle exposes these values just like a browser app.

// ---------------------------------------------------------------------------
// 1. Constants — supply via --dart-define or a secrets loader, not hard-coded.
// ---------------------------------------------------------------------------
// const String _clientKey     = String.fromEnvironment('CLIENT_KEY');
// const String _encryptionKey = String.fromEnvironment('ENCRYPTION_KEY'); // 32-char for AES-256
// const String _iv            = String.fromEnvironment('IV');             // 16-char

// ---------------------------------------------------------------------------
// 2. Low-level crypto helpers
// ---------------------------------------------------------------------------

/// Encrypts [plaintext] with AES-256-CBC and returns a Base64 ciphertext.
// String aesEncrypt(String plaintext, String keyStr, String ivStr) {
//   final key    = enc.Key.fromUtf8(keyStr.padRight(32).substring(0, 32));
//   final iv     = enc.IV.fromUtf8(ivStr.padRight(16).substring(0, 16));
//   final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
//   return encrypter.encrypt(plaintext, iv: iv).base64;
// }
String aesEncrypt(String plaintext) {
  if (kDebugMode) {
    log("ENCRYPTING DATA::: $plaintext");
  }
  final key = enc.Key.fromBase64(Env.encryptionKey);
  final iv = enc.IV.fromBase64(Env.iv);

  final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  return encrypter.encrypt(plaintext, iv: iv).base64;
}

/// Decrypts a Base64 [ciphertext] with AES-256-CBC and returns the plaintext.
// String aesDecrypt(String ciphertext, String keyStr, String ivStr) {
//   log("keyStr: $keyStr, ivStr: $ivStr");
//   final key    = enc.Key.fromUtf8(keyStr.padRight(32).substring(0, 32));
//   final iv     = enc.IV.fromUtf8(ivStr.padRight(16).substring(0, 16));
//   final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
//   return encrypter.decrypt64(ciphertext, iv: iv);
// }
String aesDecrypt(String ciphertext) {
  final key = enc.Key.fromBase64(Env.encryptionKey);
  final iv = enc.IV.fromBase64(Env.iv);

  final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  return encrypter.decrypt64(ciphertext, iv: iv);
}
