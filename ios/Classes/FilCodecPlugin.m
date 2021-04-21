#import "FilCodecPlugin.h"
#if __has_include(<fil_codec/fil_codec-Swift.h>)
#import <fil_codec/fil_codec-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fil_codec-Swift.h"
#endif

@implementation FilCodecPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFilCodecPlugin registerWithRegistrar:registrar];
}
@end
