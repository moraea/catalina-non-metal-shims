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
		if([NSProcessInfo.processInfo.arguments[0] containsString:@".prefPane"]||[NSProcessInfo.processInfo.arguments[0] containsString:@".appex"]||[NSProcessInfo.processInfo.arguments[0] containsString:@"Simulator.app"]||[NSProcessInfo.processInfo.arguments[0] containsString:@"Folx.app"])
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
	layer.cornerRadius=6;
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
		SLSWindowSetShadowPropertie$(edi_windowID,rsi_properties);
	}
	else
	{
		removeFakeRim(edi_windowID);
	}
	NSMutableDictionary* newProperties=rsi_properties.mutableCopy;
	
	newProperties[@"com.apple.WindowShadowInnerRimDensityActive"]=@0;
	newProperties[@"com.apple.WindowShadowInnerRimDensityInactive"]=@0;
	
	SLSWindowSetShadowPropertie$(edi_windowID,newProperties);
	
	newProperties.release;
}