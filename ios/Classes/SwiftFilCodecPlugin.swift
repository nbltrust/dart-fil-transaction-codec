import Flutter
import UIKit

public class SwiftFilCodecPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "fil_codec", binaryMessenger: registrar.messenger())
    let instance = SwiftFilCodecPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // Noop
    result(nil)
  }

  public func dummyMethodToEnforceBundling() {
    // dummy calls to prevent tree shaking
    ffi_dummy();
  }
}
