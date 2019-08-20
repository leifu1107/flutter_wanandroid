import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'Api.dart';

class NetUtil {
  static final debug = false;
  static BuildContext context = null;
  static final String GET = "get";
  static final String POST = "post";

  static final String DATA = "data";
  static final String CODE = "errorCode";

//   Dio dio;

//  static NetUtil _instance;
//
//  static NetUtil getInstance() {
//    if (_instance == null) {
//      _instance = NetUtil();
//    }
//    return _instance;
//  }

//  NetUtil() {
//    //  基础信息配置
//    dio = Dio(BaseOptions(
////      method: "get",
////      headers: {'platform': 'android', 'version': 1.0},
//        baseUrl: Api.baseUrl,
//        connectTimeout: 10 * 1000, //10s
//        receiveTimeout: 10 * 1000));
//  }
  ///必须每次 创建 dio,否则连续请求网络会有问题
  static Dio createInstance() {
    /// 全局属性：请求前缀、连接超时时间、响应超时时间
    Dio dio = new Dio(BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: 10 * 1000, //10s
        receiveTimeout: 10 * 1000));

    return dio;
  }

//get请求
  static get(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    await _requstHttp(url, successCallBack, GET, params, errorCallBack);
  }

  //post请求
  post(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    _requstHttp(url, successCallBack, POST, params, errorCallBack);
  }

  static _requstHttp(String url, Function successCallBack,
      [String method, FormData params, Function errorCallBack]) async {
    String errorMsg = '';
    int code;
    var dio = createInstance();
    try {
      Response response;
      _addStartHttpInterceptor(dio); //添加请求之前的拦截器
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }

      code = response.statusCode;
      if (code != 200) {
        errorMsg = '错误码：' + code.toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg);
        return;
      }
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      if (dataMap != null && dataMap[CODE] != 0) {
        errorMsg =
            '错误码：' + dataMap[CODE].toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg);
        return;
      }

      if (successCallBack != null) {
        successCallBack(dataMap);
//        successCallBack(dataMap[DATA]);
      }
    } catch (exception) {
      _error(errorCallBack, exception.toString());
    }
  }

  static _error(Function errorCallBack, String error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }

  static _addStartHttpInterceptor(Dio dio) {
    dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, logSize: 9999));
  }
//  static Future get(String url, {Map<String, dynamic> params}) async {
//    var response = await dio.get(url, queryParameters: params);
//    return response.data;
//  }
//
//  static Future post(String url, Map<String, dynamic> params) async {
//    var response = await dio.post(url, data: params);
//    return response.data;
//  }
}
