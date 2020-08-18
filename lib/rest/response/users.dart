import 'package:geideaflutter/rest/response/ads.dart';
import 'package:geideaflutter/rest/response/data.dart';

class Users{
  Users({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.ad,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Ad ad;

  factory Users.fromJson(Map<String, dynamic> json){

    return Users(
      page: json["page"],
      perPage: json["per_page"],
      total: json["total"],
      totalPages: json["total_pages"],
      data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      ad: Ad.fromJson(json["ad"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "ad": ad.toJson(),
  };

  @override
  String toString() {
    return 'Users{page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, data: $data, ad: $ad}';
  }


}