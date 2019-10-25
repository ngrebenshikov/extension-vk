#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKApplicationDelegate.h>
#import <VKSdk/VKSdk.h>
#import <SDLUIKitDelegate.h>

@implementation SDLUIKitDelegate(ProjectSDLUIKitDelegate)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	NSLog(@"openURL");
	[[FBSDKApplicationDelegate sharedInstance] application:application
        openURL:url
        sourceApplication:sourceApplication
        annotation:annotation];
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    return YES;
}

@end

@implementation ProjectSDLUIKitDelegate
@end