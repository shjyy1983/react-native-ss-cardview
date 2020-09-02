package com.shj;

import android.util.Base64;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwt;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.impl.DefaultClaims;

import okhttp3.Call;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class SsCardviewModule extends ReactContextBaseJavaModule {
  public SsCardviewModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public String getName() {
    return "SsCardview";
  }

  @ReactMethod
  public void sign(Promise callback) {
    callback.resolve("hello world 1");
  }

  @ReactMethod
  public void decode(String token, Promise callback) {
    callback.resolve("hello world 2");
  }

  @ReactMethod
  public void request(String urlString, Promise callback) {
    final String Link = urlString;
    final Promise _callback = callback;
    Runnable requestTask = new Runnable() {
      @Override
      public void run() {
          try {
              OkHttpClient client = new OkHttpClient();
              Request request = new Request.Builder().url(Link).build();
              Call call = client.newCall(request);
              Response response = call.execute();

              String result = response.body().string();
              _callback.resolve(result);
          } catch (Exception ex) {
            _callback.reject("error");
          }
        }
    };

    Thread requestThread = new Thread(requestTask);
    requestThread.start();
  }
}