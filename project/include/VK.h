#include <string>
#include <vector>

#ifndef _VK_H_
#define _VK_H_

namespace extension_vk {

	void init(std::string appId);

	void loginWithPermissions(std::vector<std::string> &permissions);

	void onTokenChange(const char *token, const char *userId, const char *email);
	void onLoginSuccessCallback();
	void onLoginFailedCallback();
	void onLoginErrorCallback(const char *error);
}

#endif
