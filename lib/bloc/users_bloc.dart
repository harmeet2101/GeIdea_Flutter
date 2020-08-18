import 'dart:async';

import 'package:geideaflutter/bloc/bloc.dart';
import 'package:geideaflutter/repository/all_users_repo.dart';
import 'package:geideaflutter/rest/Response.dart';
import 'package:geideaflutter/rest/response/users.dart';


class UsersBloc extends Bloc{


  AllUsersRepo _allUsersRepo;

  StreamController<Response<Users>> _streamController;

  Stream<Response<Users>> get streamControllerStream =>_streamController.stream;

  StreamSink<Response<Users>> get streamControllerSink=>_streamController.sink;



  UsersBloc(){
    _streamController = new StreamController<Response<Users>>.broadcast();
    _allUsersRepo = new AllUsersRepo();
  }

  void fetchUsers(bool isOffline)async{

    print('offline : $isOffline');
    streamControllerSink.add(Response.loading('Fetching users....'));
    try{
      var resp = await _allUsersRepo.fetchAllUsers(isOffline);
      print('resp: $resp');
      streamControllerSink.add(Response.completed(resp));
    }catch(e){
      streamControllerSink.add(Response.error(e.toString()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController?.close();
  }
}