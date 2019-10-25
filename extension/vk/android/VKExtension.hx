package extension.vk.android;

import haxe.Json;
#if (openfl < "4.0.0")
import openfl.utils.JNI;
#else
import lime.system.JNI;
#end


@:build(ShortCuts.mirrors())
class VKExtension {

	static function arrToString(arr : Array<String>) : String {
		if (arr==null) {
			return "";
		}
		var str = "";
		for (s in arr) {
			str += s + ",";
		}
		return str;
	}

	static var callbacksObject : VKCallbacks;

	public static function init(appId: String, onTokenChange : String->String->String->Void) {
		// trace("VKExtension::init " + appId);
		callbacksObject = new VKCallbacks();
		callbacksObject.onTokenChange = onTokenChange;
		var fn = JNI.createStaticMethod(
			"org.haxe.extension.vk.VKExtension",
			"init",
			"(Ljava/lang/String;Lorg/haxe/lime/HaxeObject;)V"
		);
		JNI.callStatic(fn, [appId, callbacksObject]);
	}

	// Login callbacks

	public static function setOnLoginSuccessCallback(f : Void->Void) {
		callbacksObject.onLoginSucess = f;
	}

	public static function setOnLoginFailedCallback(f : Void->Void) {
		callbacksObject.onLoginFailed = f;
	}

	public static function setOnLoginErrorCallback(f : String->Void) {
		callbacksObject.onLoginError = f;
	}

	
	public static function loginWithPermissions(arr : Array<String>) {
		var str = arrToString(arr);
		var fn = JNI.createStaticMethod(
			"org.haxe.extension.vk.VKExtension",
			"loginWithPermissions",
			"(Ljava/lang/String;)V"
		);
		JNI.callStatic(fn, [str]);
	}

}
