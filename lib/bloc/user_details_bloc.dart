import 'dart:async';

import 'package:geideaflutter/bloc/bloc.dart';
import 'package:geideaflutter/repository/user_details_repo.dart';
import 'package:geideaflutter/rest/Response.dart';
import 'package:geideaflutter/rest/response/user_details.dart';

class UserDetailsBloc extends Bloc{

  UserDetailsRepo _userDetailsRepo;

  StreamController<Response<UserDetails>> _streamController;

  Stream<Response<UserDetails>> get streamControllerStream =>_streamController.stream;

  StreamSink<Response<UserDetails>> get streamControllerSink=>_streamController.sink;

  StreamController<int> _counterStreamController;
  Stream<int> get counterStream =>_counterStreamController.stream;

  StreamSink<int> get counterSink=>_counterStreamController.sink;

  int counter = 5;

  UserDetailsBloc(){
    _streamController = new StreamController<Response<UserDetails>>.broadcast();
    _counterStreamController = new StreamController<int>.broadcast();
    _userDetailsRepo = new UserDetailsRepo();
  }

  void fetchUserDetails(int userId)async{

    streamControllerSink.add(Response.loading('Fetching user details....'));
    try{
      var resp = await _userDetailsRepo.fetchUserDetails(userId);
      streamControllerSink.add(Response.completed(resp));
      decrementCounter();
    }catch(e){
      streamControllerSink.add(Response.error(e.toString()));
    }
  }

  void decrementCounter()async{

     while(counter!=0){

       await new Future.delayed(Duration(milliseconds : 1000));
       counter--;
       counterSink.add(counter);
       print(counter);
     }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController?.close();
    _counterStreamController?.close();
  }
}