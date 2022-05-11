@import Foundation;
@import QuartzCore;

#include <dlfcn.h>

#import "Utils.h"

#import "Stubs.m"
#import "OldShims.m"
#import "SafariExtensions.m"
#import "Appearance.m"
#import "Rim.m"

void* getOriginalLibrary()
{
	return dlopen("/System/Library/PrivateFrameworks/SkyLight.framework/Versions/A/SkyLightOriginal",RTLD_LAZY);
}

@interface Setup:NSObject
@end

@implementation Setup

+(void)load
{
	traceLog=true;
	tracePrint=false;
	swizzleLog=false;

	appearanceSetup();
	safariSetup();
}
@end