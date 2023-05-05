import 'dart:convert';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zigy/models/server_response.dart';
import 'package:zigy/models/user.dart';

const rootApi = "https://reqres.in";
const users = "users";

class ApiController extends GetxController {
  var isLoading = false.obs;
  var idle = true.obs;

  List<UserModel> foundUsers = <UserModel>[].obs;

  clearAndReset() {
    isLoading(true);
    foundUsers.clear();

    isLoading(false);
  }

  getPaginatedUsers(int pageCount) async {
    idle(false);
    isLoading(true);
    ServerResponse users = await ApiService.getUsersByPage(pageCount);

    if (users != null) {
      for (var element in users.data) {
        UserModel userModel = UserModel.fromMap(
          element,
          users.totalPageCount,
        );

        foundUsers.add(userModel);
      }
    }

    isLoading(false);
    idle(true);
  }
}

Uri requestUri({
  @required String requestType,
}) {
  return Uri.parse(
    "$rootApi/api/$requestType",
  );
}

class ApiService {
  static var client = http.Client();

  Future<int> createUser(String name, String job) async {
    http.Response response = await client.post(
      requestUri(
        requestType: users,
      ),
      body: {
        "name": name,
        "job": job,
      },
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);

      return int.parse(data[UserModel.ID]);
    } else {
      return null;
    }
  }

  static Future<UserModel> getUserDetail(int id) async {
    http.Response response = await client.get(
      requestUri(
        requestType: "$users/$id",
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      ServerResponse rrr = ServerResponse.fromMap(
        data,
        ServerResponse.USERDETAILS,
      );

      if (rrr.data.isEmpty) {
        return null;
      } else {
        UserModel userModel = UserModel.fromMap(
          rrr.data,
          rrr.totalPageCount,
        );

        return userModel;
      }
    } else {
      return null;
    }
  }

  static Future<ServerResponse> getUsersByPage(
    int page,
  ) async {
    http.Response response = await client.get(
      requestUri(
        requestType: "$users?page=$page",
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      ServerResponse rrr = ServerResponse.fromMap(
        data,
        ServerResponse.ALLUSERS,
      );

      return rrr;
    } else {
      return null;
    }
  }
}
