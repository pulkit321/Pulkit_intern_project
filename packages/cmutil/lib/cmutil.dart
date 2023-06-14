library cmutil;
/// A Calculator.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

// String url1="https://ks74ya816b.execute-api.ap-south-1.amazonaws.com/Dev";
class AuthSrv {
  static SharedPreferences? prefs;
  static String authToken = "";
  static Stream<String> get onAuthChange => _currentUserStreamCtrl.stream;
  static StreamController<String> _currentUserStreamCtrl = StreamController<String>.broadcast();
}
class Config {
  static init() async {
    AuthSrv.prefs = await SharedPreferences.getInstance();
    AuthSrv.authToken = await Cmutil.getAuth();
    AuthSrv._currentUserStreamCtrl.sink.add(AuthSrv.authToken);
  }
}
class Cmutil {
  // void updatecookie(http.Response response){
  //
  // }
  static jsonEncode(dynamic body) {
    return json.encode(body);
//fe2kqvi5jk.execute-api.ap-south-1.amazonaws.com/Dev
  }
  static String url1="https://qa.tallyedge.com/api";
  // static jsonDecode(var test) {
  //   return jsonDecode(test);
  // }
  static setAuth(String authToken) async {
    await AuthSrv.prefs?.setString('authToken', authToken);
    // AuthSrv.onAuthChange(authToken);
    AuthSrv.authToken = authToken;
    AuthSrv._currentUserStreamCtrl.sink.add(AuthSrv.authToken);
  }

  static getAuth()async {
    final String? action = await AuthSrv.prefs?.getString('authToken');
    if (action==null) return "";
    return action;
  }

  static deleteAuth() async{
    final success = await AuthSrv.prefs?.remove('authToken');
    AuthSrv.authToken = "";
    AuthSrv._currentUserStreamCtrl.sink.add(AuthSrv.authToken);
    return success;
  }
  static var defau = "error";

  static Future<dynamic> jsonRequest({
    required String method,

    required String url_path,
    Map<String,String>? header,
    dynamic? body,
    required Function error
  }) async{
    //static String url="https://ks74ya816b.execute-api.ap-south-1.amazonaws.com/Dev";

    var client = Client();
    print(client.runtimeType);
    //get

    if (method == "get") {
      var url = Uri.parse(url1 + "/" + url_path);
      try {

        print(" HEADER2   ${header}");
        print(" BODY2   ${body}");
        var response = await client.get(url, headers: header);
        //return {body:jsonDecode(response.body),response.statusCode}
        return response;
      } catch (e) {
        error(e);
      }
    }

    //post
    else if (method == "post") {
      var url = Uri.parse(url1 + "/" + url_path);
      //String _payload = Cmutil.jsonEncode(body);
      // print(_payload);

      try {
      print("HEADER       ${header}");
      print(" BODY   ${body}");
        var response = await client.post(url, body: Cmutil.jsonEncode(body),headers: header);
        // return jsonDecode(response.body);
        return response;

      } on SocketException catch (e) {
        error(e);
      }
    }

    //PUT Request
    else if (method == "put") {
      var url = Uri.parse(url1 + "/" + url_path);
      var _payload = Cmutil.jsonEncode(body);

      try {
        var response = await client.put(url, body: _payload, headers: header);
        return jsonDecode(response.body);
      } on SocketException catch (e) {
        error(e);
      }
    }

    //delete
    else if (method == "delete") {
      var url = Uri.parse(url1 + "/" + url_path);

      try {
        var response = await client.delete(url, headers: header);
        return jsonDecode(response.body);
      } catch (e) {
        error(e);
      }
    } else {
      error();
    }
    return defau;
  }


}
