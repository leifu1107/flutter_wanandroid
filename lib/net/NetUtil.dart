import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'Api.dart';
//var dio = new Dio();

class NetUtil {
  static final debug = false;
  static BuildContext context = null;
  static final String GET = "get";
  static final String POST = "post";

  static final String DATA = "data";
  static final String CODE = "errorCode";

  Dio dio;
  static NetUtil _instance;

  static NetUtil getInstance() {
    if (_instance == null) {
      _instance = NetUtil();
    }
    return _instance;
  }

  NetUtil() {
    //  基础信息配置
    dio = Dio(BaseOptions(
//      method: "get",
//      headers: {'platform': 'android', 'version': 1.0},
        baseUrl: Api.baseUrl,
        connectTimeout: 10 * 1000, //10s
        receiveTimeout: 10 * 1000));
  }

//get请求
  get(String url, Function successCallBack, {params, Function errorCallBack}) async {
    _requstHttp(url, successCallBack, GET, params, errorCallBack);
  }

  //post请求
  post(String url, Function successCallBack, {params, Function errorCallBack}) async {
    _requstHttp(url, successCallBack, POST, params, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack, [String method, FormData params, Function errorCallBack]) async {
    String errorMsg = '';
    int code;

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

  _error(Function errorCallBack, String error) {
    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }

  _addStartHttpInterceptor(Dio dio) {
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
