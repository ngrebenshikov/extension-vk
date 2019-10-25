package extension.vk.android;

import extension.util.task.*;

class VKCallbacks extends TaskExecutor {

	public var onTokenChange : String->String->String->Void;

	public var onLoginSucess : Void->Void;
	public var onLoginFailed : Void->Void;
	public var onLoginError : String->Void;

	public function new() {
		super();
	}

	function _onTokenChange(token : String, userId : String, email: String) {
		if (onTokenChange!=null) {
			addTask(new CallStr3Task(onTokenChange, token, userId, email));
		}
	}

	function _onLoginSucess() {
		if (onLoginSucess!=null) {
			addTask(new CallTask(onLoginSucess));
		}
	}

	function _onLoginFailed() {
		if (onLoginFailed!=null) {
			addTask(new CallTask(onLoginFailed));
		}
	}

	function _onLoginError(str : String) {
		if (onLoginError!=null) {
			addTask(new CallStrTask(onLoginError, str));
		}
	}

}
