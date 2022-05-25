// fix crashes due to CALayer.delegate being released prematurely

@interface CALayer(Shim)
@end

static char KEY_RETAINED_DELEGATE;
BOOL delegateWasRetained(NSObject* delegate)
{
	if(!delegate)
	{
		return false;
	}
	
	NSNumber* value=objc_getAssociatedObject(delegate,&KEY_RETAINED_DELEGATE);
	
	return value.boolValue;
}
void setDelegateWasRetained(NSObject* delegate,BOOL flag)
{
	if(!delegate)
	{
		return;
	}
	
	objc_setAssociatedObject(delegate,&KEY_RETAINED_DELEGATE,[NSNumber numberWithBool:flag],OBJC_ASSOCIATION_RETAIN);
}
void releaseLayerDelegateIfNecessary(CALayer* layer)
{
	NSObject* delegate=[layer delegate];
	if(delegateWasRetained(delegate))
	{
		setDelegateWasRetained(delegate,false);
		delegate.release;
	}
}

@implementation CALayer(Shim)

-(void)setUnsafeUnretainedDelegate:(NSObject*)rdx
{
	[self setDelegate:rdx];
	
	rdx.retain;
	setDelegateWasRetained(rdx,true);
}

-(NSObject*)unsafeUnretainedDelegate
{
	return [self delegate];
}

@end

void (*real_setDelegate)(CALayer*,SEL,NSObject*);
void fake_setDelegate(CALayer* self,SEL sel,NSObject* delegate)
{
	releaseLayerDelegateIfNecessary(self);
	
	real_setDelegate(self,sel,delegate);
}

void (*real_dealloc)(CALayer*,SEL);
void fake_dealloc(CALayer* self,SEL sel)
{
	releaseLayerDelegateIfNecessary(self);
	
	real_dealloc(self,sel);
}

void catalystSetup()
{
	swizzleImp(@"CALayer",@"setDelegate:",true,(IMP)fake_setDelegate,(IMP*)&real_setDelegate);
	swizzleImp(@"CALayer",@"dealloc",true,(IMP)fake_dealloc,(IMP*)&real_dealloc);
}