// window borders

void SLSWindowSetShadowPropertie$(unsigned int edi_windowID,NSDictionary* rsi_properties);
BOOL rimBetaValue;
dispatch_once_t rimBetaOnce;
BOOL rimBeta()
{
	dispatch_once(&rimBetaOnce,^()
	{
		rimBetaValue=[NSUserDefaults.standardUserDefaults boolForKey:@"Moraea_RimBeta"];
		if([@[@"/System/Library/PrivateFrameworks/PaperKit.framework/Contents/LinkedNotesUIService.app/Contents/MacOS/LinkedNotesUIService",@"/System/Library/PreferencePanes/DesktopScreenEffectsPref.prefPane/Contents/Resources/DesktopPictures.prefPane/Contents/XPCServices/com.apple.preference.desktopscreeneffect.desktop.remoteservice.xpc/Contents/MacOS/com.apple.preference.desktopscreeneffect.desktop.remoteservice",@"/System/Library/PreferencePanes/DesktopScreenEffectsPref.prefPane/Contents/Resources/ScreenEffects.prefPane/Contents/XPCServices/com.apple.preference.desktopscreeneffect.screeneffects.remoteservice.xpc/Contents/MacOS/com.apple.preference.desktopscreeneffect.screeneffects.remoteservice",@"/System/Library/PrivateFrameworks/AOSUI.framework/Versions/A/XPCServices/AccountProfileRemoteViewService.xpc/Contents/MacOS/AccountProfileRemoteViewService",@"/System/Library/CoreServices/Siri.app/Contents/XPCServices/SiriNCService.xpc/Contents/MacOS/SiriNCService",@"/System/Library/PrivateFrameworks/LocalAuthenticationUI.framework/Versions/A/XPCServices/LocalAuthenticationRemoteService.xpc/Contents/MacOS/LocalAuthenticationRemoteService",@"/System/iOSSupport/System/Library/PrivateFrameworks/WorkflowUI.framework/PlugIns/WidgetConfigurationExtension.appex/Contents/MacOS/WidgetConfigurationExtension",@"/System/iOSSupport/System/Library/PrivateFrameworks/AvatarUI.framework/PlugIns/AvatarPickerMemojiPicker.appex/Contents/MacOS/AvatarPickerMemojiPicker",@"/System/iOSSupport/System/Library/PrivateFrameworks/AvatarUI.framework/PlugIns/AvatarPickerPosePicker.appex/Contents/MacOS/AvatarPickerPosePicker",@"/Applications/Folx.app/Contents/MacOS/Folx"] containsObject:NSProcessInfo.processInfo.arguments[0]])
		{
			rimBetaValue=0;
		}
	});
	return rimBetaValue;
}

dispatch_once_t layerNewWayOnce;
NSObject* layerNewWayNSApp;
CALayer* layerNewWay(int wid)

{
		dispatch_once(&layerNewWayOnce,^()
		{
			Class NSApplication=NSClassFromString(@"NSApplication");
			layerNewWayNSApp=[NSApplication sharedApplication];
		});
	
		NSObject* window=[layerNewWayNSApp windowWithWindowNumber:wid];
		NSObject* view=[window _borderView];
	
		if([NSStringFromClass(view.class) isEqual:@"NSNextStepFrame"])
		{
			[view setWantsLayer:true];
		}
		
		CALayer* layer=[view layer];
		while(layer.superlayer)
		{
			layer=layer.superlayer;
		}
	
		trace(@"LNW %@ %@ %@ %@",layerNewWayNSApp,window,view,layer);
	
		return layer;
}

void addFakeRim(unsigned int windowID)
{
	CALayer* layer=layerNewWay(windowID);
	layer.borderWidth=1;
	CGColorRef color=CGColorCreateGenericRGB(1.0,1.0,1.0,0.2);
	layer.borderColor=color;
	CFRelease(color);
}

void removeFakeRim(unsigned int windowID)
{
	CALayer* layer=layerNewWay(windowID);
	layer.borderWidth=0;
}

void SLSWindowSetShadowProperties(unsigned int edi_windowID,NSDictionary* rsi_properties)
{	
	NSNumber* value=rsi_properties[@"com.apple.WindowShadowInnerRimStyleWhiteActive"];
	if(rimBeta()&&value&&value.doubleValue==1)
	{
		addFakeRim(edi_windowID);
	}
	else
	{
		removeFakeRim(edi_windowID);
	}
	SLSWindowSetShadowPropertie$(edi_windowID,rsi_properties);
}
