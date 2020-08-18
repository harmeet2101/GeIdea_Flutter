import 'dart:convert';

import 'package:geideaflutter/rest/api_provider.dart';
import 'package:geideaflutter/rest/response/users.dart';
import 'package:geideaflutter/utils/AppConstants.dart';

class AllUsersRepo{


  ApiProvider _apiProvider = new ApiProvider();


  Future<Users> fetchAllUsers()async{
    var resp = await _apiProvider.getResponse(AppConstants.USERS_END_POINT);
    Users users =  Users.fromJson(resp);
    return users;

  }
}