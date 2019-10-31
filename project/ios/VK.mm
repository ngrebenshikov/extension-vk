#import <VKCallbacksDelegate.h>
#import <VKSdk/VKSdk.h>

#import <VK.h>

namespace extension_vk {

	VKCallbacksDelegate *callbacks;
	UIViewController *root;

	void init(std::string appId) {
		root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
		callbacks = [[VKCallbacksDelegate alloc] init];
		[VKSdk initializeWithAppId:[NSString stringWithUTF8String:appId.c_str()]];
		[[VKSdk instance] registerDelegate: callbacks];
		[[VKSdk instance] setUiDelegate: callbacks];
		
	}

	void loginWithPermissions(std::vector<std::string> &permissions) {
		NSMutableArray *nsPermissions = [[NSMutableArray alloc] init];
		for (auto p : permissions) {
			[nsPermissions addObject:[NSString stringWithUTF8String:p.c_str()]];
		}
		[VKSdk authorize:nsPermissions];
	}
}
