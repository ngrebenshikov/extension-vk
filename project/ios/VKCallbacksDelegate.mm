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
		extension_vk::onTokenChange([result.token.accessToken UTF8String], [result.token.userId UTF8String], email);
		extension_vk::onLoginSuccessCallback();
	} else if (result.error) { 
		extension_vk::onLoginErrorCallback([result.error.localizedDescription UTF8String]);
	} else {
		extension_vk::onLoginFailedCallback();
	}
}

- (void)vkSdkUserAuthorizationFailed {
		extension_vk::onLoginFailedCallback();
}

@end
