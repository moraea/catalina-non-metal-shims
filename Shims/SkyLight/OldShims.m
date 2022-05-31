// assertions
unsigned long SLSReenableUpdateTokenWithSeed()
{
	return 0;
}
// freezing regions caused by above
unsigned long SLSDisableUpdateToken()
{
	return 0;
}
unsigned long SLSReenableUpdateToken()
{
	return 0;
}
// references to old SkyLight
void SLSSessionSwitchToAuditSessionID(int64_t);
void SLSSetDockRectWithReason(int64_t,CGRect,int64_t);
void SLSGetDockRectWithReason(int64_t,CGRect*,int64_t);

// logout and switch-user
void SLSSessionSwitchToAuditSessionIDWithOptions(int64_t sessionID,NSDictionary* transitionStuff)
{
	SLSSessionSwitchToAuditSessionID(sessionID);
}

// references to private HIServices
// stolen from https://github.com/rcarmo/qsb-mac/blob/master/QuickSearchBox/externals/UndocumentedGoodness/CoreDock/CoreDockPrivate.h
typedef enum
{
	kCoreDockOrientationTop=1,
	kCoreDockOrientationBottom=2,
	kCoreDockOrientationLeft=3,
	kCoreDockOrientationRight=4
}
CoreDockOrientation;
typedef enum
{
	kCoreDockPinningStart=1,
	kCoreDockPinningMiddle=2,
	kCoreDockPinningEnd=3
}
CoreDockPinning;
void CoreDockGetOrientationAndPinning(CoreDockOrientation *orientation,CoreDockPinning *pinning);

// Dock collisions
void SLSSetDockRectWithOrientation(int64_t connection,CGRect rect,int64_t reason,int orientation)
{
	SLSSetDockRectWithReason(connection,rect,reason);
}
void SLSGetDockRectWithOrientation(int64_t connection,CGRect* rect,int64_t reason,CoreDockOrientation* orientation)
{
	SLSGetDockRectWithReason(connection,rect,reason);
	
	CoreDockPinning pinningIgnored;
	CoreDockGetOrientationAndPinning(orientation,&pinningIgnored);
}

// TCC permissions-related functions
// just return true since they weren't restricted in Mojave
// this fixes screen recording access in AltTab and probably other things
bool SLSRequestListenEventAccess()
{
	return true;
}
bool SLSRequestPostEventAccess()
{
	return true;
}
bool SLSRequestScreenCaptureAccess()
{
	return true;
}

// based on class-dump'ed DP9 SkyLight
@interface SLDataTimelineConfig:NSObject
	+(id)configWithName:(id)arg1 andUpdateBlock:(void*)arg2;
	-(void)establishConnectionWithResultBlock:(void*)arg1;
	-(id)createXPCObject;
	-(id)createNoSenderRecvPairWithQueue:(id)arg1 errorHandler:(void*)arg2 eventHandler:(void*)arg3;
	-(id)createCancellableMachRecvSourceWithQueue:(id)arg1 cancelAction:(void*)arg2 error:(id *)arg3;
	-(void)requestSampleIntervalValue:(unsigned short)arg1 forKey:(id)arg2;
	-(void)requestReportIntervalValue:(unsigned short)arg1 forKey:(id)arg2;
	-(void)addInfoOption:(id)arg1;
	-(void)setTargetQueue:(id)arg1;
	-(id)initWithName:(id)arg1 andUpdateBlock:(void*)arg2;
@end
@implementation SLDataTimelineConfig
	+(id)configWithName:(id)arg1 andUpdateBlock:(void*)arg2
	{
		return nil;
	}
	-(void)establishConnectionWithResultBlock:(void*)arg1
	{
	}
	-(id)createXPCObject
	{
		return nil;
	}
	-(id)createNoSenderRecvPairWithQueue:(id)arg1 errorHandler:(void*)arg2 eventHandler:(void*)arg3
	{
		return nil;
	}
	-(id)createCancellableMachRecvSourceWithQueue:(id)arg1 cancelAction:(void*)arg2 error:(id *)arg3
	{
		return nil;
	}
	-(void)requestSampleIntervalValue:(unsigned short)arg1 forKey:(id)arg2
	{
	}
	-(void)requestReportIntervalValue:(unsigned short)arg1 forKey:(id)arg2
	{
	}
	-(void)addInfoOption:(id)arg1
	{
	}
	-(void)setTargetQueue:(id)arg1
	{
	}
	-(id)initWithName:(id)arg1 andUpdateBlock:(void*)arg2
	{
		return nil;
	}
@end

// copied from new SkyLight
NSString* kSLSSessionSwitchTransitionTypeCube=@"cube";
NSString* kSLSSessionSwitchTransitionTypeKey=@"transition";
NSString* kSLSSessionSwitchTransitionTypeNone=@"none";
NSString* kSLSSessionSwitchTransitionTypeUnset=@"";

// PowerlogLiteOperators
NSString* kSLDataTimelineInfoOptionPerProcessWindows=@"";
NSString* kSLDataTimelineReportIntervalSnapshotCountKey=@"";
NSString* kSLDataTimelineReportIntervalTimeInSecondsKey=@"";
NSString* kSLDataTimelineReportIntervalReportInKiBKey=@"";
NSString* kSLDataTimelineSampleIntervalSnapshotCountKey=@"";
NSString* kSLDataTimelineSampleIntervalTimeInSecondsKey=@"";

// loginwindow
NSString* kSLSCaptureDisablePrompting=@"";
NSString* kSLSCaptureIgnoreTCCPermissions=@"";