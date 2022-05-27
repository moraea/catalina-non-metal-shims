#import "Utils.h"
#import "Stubs.m"
#import "Videos.m"
#import "Catalyst.m"
#import "Misc.m"

__attribute__((constructor))
void load()
{
	traceLog=true;
	tracePrint=false;
	swizzleLog=false;

	miscSetup();
}