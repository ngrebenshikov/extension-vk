#import <VKSdk/VKSdk.h>

@class VKCallbacksDelegate;

@interface VKCallbacksDelegate : NSObject <
	VKSdkDelegate,
	VKSdkUIDelegate
>

@end
