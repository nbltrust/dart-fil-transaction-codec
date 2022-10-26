import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fil_codec_method_channel.dart';

abstract class FilCodecPlatform extends PlatformInterface {
  /// Constructs a FilCodecPlatform.
  FilCodecPlatform() : super(token: _token);

  static final Object _token = Object();

  static FilCodecPlatform _instance = MethodChannelFilCodec();

  /// The default instance of [FilCodecPlatform] to use.
  ///
  /// Defaults to [MethodChannelFilCodec].
  static FilCodecPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FilCodecPlatform] when
  /// they register themselves.
  static set instance(FilCodecPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
