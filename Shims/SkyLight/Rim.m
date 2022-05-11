// window borders

void SLSWindowSetShadowPropertie$(unsigned int edi_windowID,NSDictionary* rsi_properties);
BOOL rimBetaValue;
dispatch_once_t rimBetaOnce;
BOOL rimBeta()
{
	dispatch_once(&rimBetaOnce,^()
	{
		rimBetaValue=[NSUserDefaults.standardUserDefaults boolForKey:@"Moraea_RimBeta"];
		if(getpid()<200)
		{
	    		return;
		}
		if([@[@"/System/Applications/Calendar.app/Contents/PlugIns/com.apple.iCal.CalendarNC.appex/Contents/MacOS/com.apple.iCal.CalendarNC",@"/Applications/Folx.app/Contents/MacOS/Folx",@"/System/Library/CoreServices/NotificationCenter.app/Contents/MacOS/NotificationCenter",@"/System/Library/CoreServices/Weather.app/Contents/PlugIns/com.apple.ncplugin.weather.appex/Contents/MacOS/com.apple.ncplugin.weather",@"/System/Library/CoreServices/StocksWidget.app/Contents/PlugIns/com.apple.ncplugin.stocks.appex/Contents/MacOS/com.apple.ncplugin.stocks"] containsObject:NSProcessInfo.processInfo.arguments[0]] || [NSProcessInfo.processInfo.arguments[0] containsString:@"/System/Library/PreferencePanes"])
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
	NSNumber* value=rsi_properties[@"com.apple.WindowShadowRimDensityActive"];
	if(rimBeta()==1&&value&&value.doubleValue>=0.7)
	{
		addFakeRim(edi_windowID);
	}
	else
	{
		removeFakeRim(edi_windowID);
	}
	SLSWindowSetShadowPropertie$(edi_windowID,rsi_properties);
}
