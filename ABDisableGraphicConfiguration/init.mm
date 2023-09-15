//
//  init.mm
//  ABDisableGraphicConfiguration
//
//  Created by Jinwoo Kim on 9/15/23.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

namespace ABDeviceSceneViewController {
namespace _setupSceneIfNeeded {
static void (*original)(id self, SEL _cmd);
static void custom(id self, SEL _cmd) {
    // do nothing
}

static void swizzle() {
    Method method = class_getInstanceMethod(NSClassFromString(@"ABDeviceSceneViewController"), NSSelectorFromString(@"_setupSceneIfNeeded"));
    original = reinterpret_cast<void (*)(id, SEL)>(*method_getImplementation(method));
    method_setImplementation(method, reinterpret_cast<IMP>(&custom));
}
}
}

__attribute__((constructor)) static void init() {
    ABDeviceSceneViewController::_setupSceneIfNeeded::swizzle();
}
