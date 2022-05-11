// Safari extension checkboxes

BOOL fake_validateNoOcclusionSinceToken(id self,SEL selector,void* rdx)
{
	trace(@"fake_validateNoOcclusionSinceToken");
	
	return true;
}

@interface SkyLightStubClass:NSObject
@end

@implementation SkyLightStubClass
@end

@interface SLSecureCursorAssertion:SkyLightStubClass
@end

@implementation SLSecureCursorAssertion

+(instancetype)assertion
{
	trace(@"SLSecureCursorAssertion assertion");
	
	return SLSecureCursorAssertion.alloc.init.autorelease;
}

-(BOOL)isValid
{
	trace(@"SLSecureCursorAssertion isValid");
	
	return true;
}

@end

BOOL fake_canEnableExtensions()
{
	trace(@"fake_canEnableExtensions");
	
	return true;
}

void safariSetup()
{
	if(getpid()<200)
	{
    		return;
	}
	if([NSProcessInfo.processInfo.arguments[0] containsString:@"Safari"])
	{
		swizzleImp(@"ExtensionsPreferences",@"canEnableExtensions",true,(IMP)fake_canEnableExtensions,NULL);
	}
}