#import <VKCallbacksDelegate.h>
#import <VK.h>
#import <UIKit/UIKit.h>
#import <VKSdk/VKSdk.h>

@implementation VKCallbacksDelegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
	if (result.token) { 
		const char *email = NULL;
		if (result.token.email) {
			email = [result.token.email UTF8String];
		}
		dispatch_async(dispatch_get_main_queue(), ^{	
			extension_vk::onTokenChange([result.token.accessToken UTF8String], [result.token.userId UTF8String], email);
			extension_vk::onLoginSuccessCallback();
		});
	} else if (result.error) { 
		dispatch_async(dispatch_get_main_queue(), ^{	
			extension_vk::onLoginErrorCallback([result.error.localizedDescription UTF8String]);
		});
	} else {
		dispatch_async(dispatch_get_main_queue(), ^{	
			extension_vk::onLoginFailedCallback();
		});
	}
}

- (void)vkSdkUserAuthorizationFailed {
	dispatch_async(dispatch_get_main_queue(), ^{	
		extension_vk::onLoginFailedCallback();
	});
}

@end
