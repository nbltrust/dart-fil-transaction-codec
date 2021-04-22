import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'bindings.dart';

const DYNAMIC_LIBRARY_FILE_NAME = "";

/// Wraps the native functions and converts specific data types in order to
/// handle C strings.

class FilCodec {
  static final FilCodecBindings _bindings = FilCodecBindings(FilCodec._loadLibrary());

  static DynamicLibrary _loadLibrary() {
    return Platform.isAndroid
        ? DynamicLibrary.open(DYNAMIC_LIBRARY_FILE_NAME)
        : DynamicLibrary.process();
  }

  static String publicKeyToAddress(String plainKey, {bool testnet = false}) {
    final ptrPlainKey = Utf8.toUtf8(plainKey).cast<Int8>();

    // Native call
    final ptrResult = _bindings.public_key_to_address(ptrPlainKey, testnet ? 1 : 0);

    // Cast the result pointer to a Dart string
    final result = Utf8.fromUtf8(ptrResult.cast<Utf8>());

    // Clone the given result, so that the original string can be freed
    final resultCopy = "" + result;

    // Free the native value
    FilCodec._free(result);

    return resultCopy;
  }

  static String txDecode(String hex, {bool testnet = false}) {
    final ptrHex = Utf8.toUtf8(hex).cast<Int8>();

    // Native call
    final ptrResult = _bindings.tx_decode(ptrHex, testnet ? 1 : 0);

    // Cast the result pointer to a Dart string
    final result = Utf8.fromUtf8(ptrResult.cast<Utf8>());

    // Clone the given result, so that the original string can be freed
    final resultCopy = "" + result;

    // Free the native value
    FilCodec._free(result);

    return resultCopy;
  }

  static String txEncode(String json) {
    final ptrJson = Utf8.toUtf8(json).cast<Int8>();

    // Native call
    final ptrResult = _bindings.tx_encode(ptrJson);

    // Cast the result pointer to a Dart string
    final result = Utf8.fromUtf8(ptrResult.cast<Utf8>());

    // Clone the given result, so that the original string can be freed
    final resultCopy = "" + result;

    // Free the native value
    FilCodec._free(result);

    return resultCopy;
  }

  static String txDigest(String hex) {
    final ptrHex = Utf8.toUtf8(hex).cast<Int8>();

    // Native call
    final ptrResult = _bindings.tx_digest(ptrHex);

    // Cast the result pointer to a Dart string
    final result = Utf8.fromUtf8(ptrResult.cast<Utf8>());

    // Clone the given result, so that the original string can be freed
    final resultCopy = "" + result;

    // Free the native value
    FilCodec._free(result);

    return resultCopy;
  }

  /// Releases the memory allocated to handle the given (result) value
  static void _free(String value) {
    final ptr = Utf8.toUtf8(value).cast<Void>();
    return _bindings.ffi_free(ptr);
  }
}
