

import 'package:geideaflutter/rest/Status.dart';

class Response<T>{

  T data;
  String message;
  Status status;


  Response.loading(this.message):status=Status.LOADING;
  Response.completed(this.data):status=Status.COMPLETED;
  Response.error(this.message):status=Status.ERROR;


}