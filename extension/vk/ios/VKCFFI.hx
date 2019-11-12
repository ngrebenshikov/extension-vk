package extension.vk.ios;

@:build(ShortCuts.mirrors())
@CPP_DEFAULT_LIBRARY("extension_vk")
@CPP_PRIMITIVE_PREFIX("extension_vk")
class VKCFFI {


	@CPP public static function init(appId: String, onTokenChange : String->String->String -> Void) {}
	@CPP public static function loginWithPermissions(permissions : Array<String> = null) {}
	@CPP public static function logout() {}

	@CPP public static function setOnLoginSuccessCallback(f : Void->Void);
	@CPP public static function setOnLoginFailedCallback(f : Void->Void);
	@CPP public static function setOnLoginErrorCallback(f : String->Void);

}
