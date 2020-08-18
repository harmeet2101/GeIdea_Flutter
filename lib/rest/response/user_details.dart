import 'package:geideaflutter/rest/response/ads.dart';
import 'package:geideaflutter/rest/response/data.dart';

class UserDetails{

  Data data;
  Ad ad;

  UserDetails({this.data,this.ad});

  factory UserDetails.fromJson(Map<String,dynamic> json){

    return UserDetails(

      data: Data.fromJson(json['data']),
      ad: Ad.fromJson(json['ad']),
    );
  }

  @override
  String toString() {
    return 'UserDetails{data: $data, ad: $ad}';
  }


}