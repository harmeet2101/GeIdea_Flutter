import 'dart:io';

import 'package:geideaflutter/rest/custom_exception.dart';
import 'package:geideaflutter/utils/AppConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider{

  final String BASE_URL = AppConstants.BASE_URL;


  Future<dynamic> getResponse(String endPoint) async{
    var dynamicResponse;


    try {
      var url = BASE_URL + endPoint ;
      var resp = await http.get(url);
      dynamicResponse = parseResponse(resp);
    } on SocketException catch (e) {
      throw CustomException('Network Exception',e.toString());
    }

    return dynamicResponse;
  }

  dynamic parseResponse(http.Response response){

    switch(response.statusCode){

      case 200:
        return json.decode(response.body);
      case 400:
          throw BadRequestException(response.body);
      case 401:
        break;
      case 403:
        throw UnauthorizedException(response.body);
      case 404:
        throw ResourceNotFoundException(response.body);
      case 500:
        throw ServerException(response.body.toString());
      default:{

        throw CustomException('statusCode: ${response.statusCode}',response.body.toString());
      }
    }

  }
}