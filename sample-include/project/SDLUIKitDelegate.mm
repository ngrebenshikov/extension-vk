#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKApplicationDelegate.h>
#import <VKSdk/VKSdk.h>
#import <SDLUIKitDelegate.h>

extern "C" {
    #include <SDL_video.h>
    #include <SDL_dropevents_c.h>
}

@implementation SDLUIKitDelegate(ProjectSDLUIKitDelegate)

- (void)sendDropFileForURL:(NSURL *)url {
    NSURL *fileURL = url.filePathURL;
    if (fileURL != nil) {
        SDL_SendDropFile(NULL, fileURL.path.UTF8String);
    } else {
        SDL_SendDropFile(NULL, url.absoluteString.UTF8String);
    }
    SDL_SendDropComplete(NULL);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	NSLog(@"openURL");
	[[FBSDKApplicationDelegate sharedInstance] application:application
        openURL:url
        sourceApplication:sourceApplication
        annotation:annotation];
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    [self sendDropFileForURL:url];
    return YES;
}

@end

@implementation ProjectSDLUIKitDelegate
@end