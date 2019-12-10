
package extension.vk;

#if android
import extension.vk.android.VKCFFI;
#elseif ios
import extension.vk.ios.VKCFFI;
#end

import extension.util.task.*;

// NSString *const VK_PER_NOTIFY = @"notify";
// NSString *const VK_PER_FRIENDS = @"friends";
// NSString *const VK_PER_PHOTOS = @"photos";
// NSString *const VK_PER_AUDIO = @"audio";
// NSString *const VK_PER_VIDEO = @"video";
// NSString *const VK_PER_DOCS = @"docs";
// NSString *const VK_PER_NOTES = @"notes";
// NSString *const VK_PER_PAGES = @"pages";
// NSString *const VK_PER_STATUS = @"status";
// NSString *const VK_PER_WALL = @"wall";
// NSString *const VK_PER_GROUPS = @"groups";
// NSString *const VK_PER_MESSAGES = @"messages";
// NSString *const VK_PER_NOTIFICATIONS = @"notifications";
// NSString *const VK_PER_STATS = @"stats";
// NSString *const VK_PER_ADS = @"ads";
// NSString *const VK_PER_OFFLINE = @"offline";
// NSString *const VK_PER_NOHTTPS = @"nohttps";
// NSString *const VK_PER_EMAIL = @"email";
// NSString *const VK_PER_MARKET = @"market";

class VK extends TaskExecutor {

	static var initted = false;
	public var accessToken : String;
	public var userId : String;
	public var email : String;
	public var appId(default, null): String;

	private var initCallback:Bool->Void;
	private static var instance:VK=null;

	public static function getInstance():VK{
		if(instance==null) instance = new VK();
		return instance;
	}

	private function new() {
		accessToken = "";
		super();
	}

	public function init(appId: String, ?initCallback:Bool->Void) {
		if (!initted) {
			this.appId = appId;
			#if (android || ios)
			this.initCallback = initCallback;
			VKCFFI.init(appId, this.setAuthToken);
			#end
		}
	}

	public function setAuthToken(token, userId, email) {
		if (token != "") {
			initted = true;
		}
		this.accessToken = token;
		this.userId = userId;
		this.email = email;
		if (this.initCallback != null) {
			this.initCallback(true);
		}
	}

	public function login(
		permissions : Array<String>,
		onComplete : Void->Void,
		onFailed : Void->Void,
		onError : String->Void
	) {

		trace("VK.login");

		var fOnComplete = function() {
			addTask(new CallTask(onComplete));
		}

		var fOnFailed = function() {
			addTask(new CallTask(onFailed));
		}

		var fOnError = function(error) {
			addTask(new CallStrTask(onError, error));
		}

		#if (android || ios)

		VKCFFI.setOnLoginSuccessCallback(fOnComplete);
		VKCFFI.setOnLoginFailedCallback(fOnFailed);
		VKCFFI.setOnLoginErrorCallback(fOnError);

		VKCFFI.loginWithPermissions(permissions);

		#end
		
	}

	public function logout() {
		if (accessToken != null && accessToken != "") {
			#if (android || ios)
			VKCFFI.logout();
			#end
			setAuthToken("", null, null);
		}
	}

}
