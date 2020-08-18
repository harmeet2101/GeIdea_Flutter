


import 'package:geideaflutter/bloc/bloc.dart';
import 'package:geideaflutter/bloc/user_details_bloc.dart';
import 'package:geideaflutter/bloc/users_bloc.dart';

class AppBloc extends Bloc{

  UsersBloc _usersBloc;
  UserDetailsBloc _userDetailsBloc;

  UsersBloc get userBloc =>_usersBloc;
  UserDetailsBloc get userDetailsBloc =>_userDetailsBloc;

  AppBloc(){

    _usersBloc = new UsersBloc();
    _userDetailsBloc = new UserDetailsBloc();

  }




  @override
  void dispose() {
    // TODO: implement dispose
    _usersBloc?.dispose();
    _userDetailsBloc?.dispose();
  }

}