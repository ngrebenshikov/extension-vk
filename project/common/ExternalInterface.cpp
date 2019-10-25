#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include <hxcpp.h>

#include <string>
#include <vector>

#include <VK.h>

#define safe_alloc_string(a) (alloc_string(a!=NULL ? a : ""))
#define safe_val_call0(func) if (func!=NULL) val_call0(func->get())
#define safe_val_call1(func, arg1) if (func!=NULL) val_call1(func->get(), arg1)
#define safe_val_call3(func, arg1, arg2, arg3) if (func!=NULL) val_call3(func->get(), arg1, arg2, arg3)
#define safe_val_string(str) str==NULL ? "" : std::string(val_string(str))

AutoGCRoot* _onVKTokenChange;
AutoGCRoot* _onVKLoginSuccessCallback;
AutoGCRoot* _onVKLoginFailedCallback;
AutoGCRoot* _onVKLoginErrorCallback;

void extension_vk::onTokenChange(const char *token, const char *userId, const char *email) {
	safe_val_call3(_onVKTokenChange, safe_alloc_string(token), safe_alloc_string(userId), safe_alloc_string(email));
}

void extension_vk::onLoginSuccessCallback() {
	safe_val_call0(_onVKLoginSuccessCallback);
}

void extension_vk::onLoginFailedCallback() {
	safe_val_call0(_onVKLoginFailedCallback);
}

void extension_vk::onLoginErrorCallback(const char *error) {
	safe_val_call1(_onVKLoginErrorCallback, safe_alloc_string(error));
}

static value extension_vk_init(value appId, value onTokenChange) {
	_onVKTokenChange = new AutoGCRoot(onTokenChange);
	extension_vk::init(safe_val_string(appId));
	return alloc_null();
}
DEFINE_PRIM(extension_vk_init, 2);


static value extension_vk_loginWithPermissions(value permissions) {
	int n = 0;
	if (permissions!=NULL) {
		n = val_array_size(permissions);
	}
	std::vector<std::string> stlPermissions;
	for (int i=0;i<n;++i) {
		std::string str(val_string(val_array_i(permissions, i)));
		stlPermissions.push_back(str);
	}
	extension_vk::loginWithPermissions(stlPermissions);
	return alloc_null();
}
DEFINE_PRIM(extension_vk_loginWithPermissions, 1);


static value extension_vk_setOnLoginSuccessCallback(value fun) {
	_onVKLoginSuccessCallback = new AutoGCRoot(fun);
	return alloc_null();
}
DEFINE_PRIM(extension_vk_setOnLoginSuccessCallback, 1);

static value extension_vk_setOnLoginFailedCallback(value fun) {
	_onVKLoginFailedCallback = new AutoGCRoot(fun);
	return alloc_null();
}
DEFINE_PRIM(extension_vk_setOnLoginFailedCallback, 1);

static value extension_vk_setOnLoginErrorCallback(value fun) {
	_onVKLoginErrorCallback = new AutoGCRoot(fun);
	return alloc_null();
}
DEFINE_PRIM(extension_vk_setOnLoginErrorCallback, 1);

extern "C" void extension_vk_main () {
	val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT (extension_vk_main);

extern "C" int extension_vk_register_prims () {
	return 0;
}
