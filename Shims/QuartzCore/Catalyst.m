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