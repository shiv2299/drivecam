import 'package:dio/dio.dart';
import 'package:drivecam/models/user_model.dart';
import 'package:drivecam/resources/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  Dio dio = Dio();
  Future<Response> register(User user) async {
    Response response =
        await dio.post(URL.url + "user", data: FormData.fromMap(user.toJson()));
    return response;
  }

  Future<Response> loginFace(data) async {
    Response response = await dio.post(URL.url + "user/loginFace",
        data: FormData.fromMap({"face_data": data}));
    return response;
  }

  Future<Response> login(username, password) async {
    Response response = await dio.post(URL.url + "user/login",
        data: FormData.fromMap({"username": username, "password": password}));
    return response;
  }

  Future<Response> getUserByEmail(email) async {
    Response response = await dio.post(URL.url + "user/getUserByEmail",
        data: FormData.fromMap({
          "username": email,
        }));
    return response;
  }

  storeUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", id);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    return id;
  }
}
