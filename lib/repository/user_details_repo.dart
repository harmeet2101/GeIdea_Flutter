import 'package:geideaflutter/rest/api_provider.dart';
import 'package:geideaflutter/rest/response/user_details.dart';
import 'package:geideaflutter/utils/AppConstants.dart';

class UserDetailsRepo{

  ApiProvider _apiProvider = new ApiProvider();



  fetchUserDetails(int userId) async{
    var resp = await _apiProvider.getResponse(AppConstants.USER_DETAILS_END_POINT.
    replaceAll("{id}", '$userId'));
    UserDetails userDetails =  UserDetails.fromJson(resp);
    return userDetails;

  }

}