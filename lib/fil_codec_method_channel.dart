import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fil_codec_platform_interface.dart';

/// An implementation of [FilCodecPlatform] that uses method channels.
class MethodChannelFilCodec extends FilCodecPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fil_codec');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
