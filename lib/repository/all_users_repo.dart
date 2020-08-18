import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:geideaflutter/database/db_helper.dart';
import 'package:geideaflutter/rest/api_provider.dart';
import 'package:geideaflutter/rest/response/data.dart';
import 'package:geideaflutter/rest/response/users.dart';
import 'package:geideaflutter/utils/AppConstants.dart';


class AllUsersRepo{


  ApiProvider _apiProvider = new ApiProvider();
  SQLiteDBHelper _sqLiteDBHelper;

  AllUsersRepo(){

    _sqLiteDBHelper = new SQLiteDBHelper();
    _sqLiteDBHelper.openDb();
  }

  Future<Users> fetchAllUsers(bool isOffline)async{
    Users users = null;
    if(!isOffline){
      var resp = await _apiProvider.getResponse(AppConstants.USERS_END_POINT);
      users =  Users.fromJson(resp);
      if(users!=null)
        _sqLiteDBHelper.insertData(users.data);
    }else{

      Future<List<Data>> data = _sqLiteDBHelper.dataList();
      List<Data> dataList = null;
      await data.then((value) {

        dataList =  value;

      });

      users = new Users(data: dataList);
    }


    return users;

  }



}