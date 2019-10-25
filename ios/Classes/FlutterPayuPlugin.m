#import "FlutterPayuPlugin.h"
#import <flutter_payu/flutter_payu-Swift.h>

@implementation FlutterPayuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPayuPlugin registerWithRegistrar:registrar];
}
@end
