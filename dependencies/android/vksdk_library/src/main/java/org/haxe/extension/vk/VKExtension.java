package org.haxe.extension.vk;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import java.security.MessageDigest;
import android.util.Base64;
import android.content.pm.PackageManager.NameNotFoundException;
import java.security.NoSuchAlgorithmException;

import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.vk.sdk.*;
import com.vk.sdk.api.*;

public class VKExtension extends Extension {
	static SecureHaxeObject callbacks;
	static final String TAG = "VK-EXTENSION";

	public VKExtension() {}

	// Static methods interface

	public static void init(String appId, HaxeObject _callbacks) {
		// Log.i(TAG, "VKExtension.init " + appId);
		callbacks = new SecureHaxeObject(_callbacks, mainActivity, TAG);
		VKSdk.customInitialize(mainContext, Integer.parseInt(appId), null);
	}

	public static void loginWithPermissions(String permissions) {
		String[] arr = permissions.split(";");
		VKSdk.login(mainActivity, arr);
	}


	@Override public void onCreate (Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}

	@Override public boolean onActivityResult (int requestCode, int resultCode, Intent data) {
	    if (!VKSdk.onActivityResult(requestCode, resultCode, data, new VKCallback<VKAccessToken>() {
	        @Override
	        public void onResult(VKAccessToken res) {
					if (callbacks!=null) {
						callbacks.call3("_onTokenChange", res.accessToken, res.userId, res.email);
						callbacks.call0("_onLoginSucess");
					}
	        }
	        @Override
	        public void onError(VKError error) {
					if (callbacks!=null) {
						callbacks.call1("_onLoginError", error.errorMessage);
					}
	        }
	    })) {
	        super.onActivityResult(requestCode, resultCode, data);
	    }
		return true;
	}

	@Override public void onDestroy() {
		super.onDestroy();
	}

}
