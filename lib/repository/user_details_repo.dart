import 'package:geideaflutter/database/db_helper.dart';
import 'package:geideaflutter/rest/api_provider.dart';
import 'package:geideaflutter/rest/response/data.dart';
import 'package:geideaflutter/rest/response/user_details.dart';
import 'package:geideaflutter/utils/AppConstants.dart';

class UserDetailsRepo{

  ApiProvider _apiProvider = new ApiProvider();
  SQLiteDBHelper _sqLiteDBHelper;

  UserDetailsRepo(){
    _sqLiteDBHelper = new SQLiteDBHelper();
  }

  fetchUserDetails(int userId,bool isOffline) async{
    UserDetails userDetails = null;
    if(!isOffline) {
      var resp = await _apiProvider.getResponse(
          AppConstants.USER_DETAILS_END_POINT.
          replaceAll("{id}", '$userId'));
       userDetails = UserDetails.fromJson(resp);
    }else{
      Future<Data> dataFuture = _sqLiteDBHelper.findById(userId);
      Data data = null;

      await dataFuture.then((value) {

        data =  value;
        print(data);

      });

      userDetails = new UserDetails(data: data,ad: null);
    }
    return userDetails;

  }

}