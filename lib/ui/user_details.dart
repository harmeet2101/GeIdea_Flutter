import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geideaflutter/bloc/app_bloc.dart';
import 'package:geideaflutter/bloc/bloc_provider.dart';
import 'package:geideaflutter/bloc/user_details_bloc.dart';
import 'package:geideaflutter/rest/Response.dart';
import 'package:geideaflutter/rest/Status.dart';
import 'package:geideaflutter/rest/response/data.dart';
import 'package:geideaflutter/rest/response/user_details.dart';

class UserDetailsScreen extends StatefulWidget{

  int userId;

  UserDetailsScreen({this.userId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserState();
  }
}

class UserState extends State<UserDetailsScreen>{

  AppBloc _appBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc  = BlocProvider.of<AppBloc>(context);
    UserDetailsBloc userDetailsBloc = _appBloc.userDetailsBloc;
    userDetailsBloc.fetchUserDetails(widget.userId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<int>(builder:(context,snapshot){

                  if(snapshot.hasData){
                    removeTask(snapshot.data);
                    return Text('Counter: ${snapshot.data}',style: TextStyle(color: Colors.red,fontSize: 22),);
                  }else{
                    return Text('Counter: 5',style: TextStyle(color: Colors.red,fontSize: 22),);
                  }
                },stream: _appBloc.userDetailsBloc.counterStream,),
              )
            ],
          ),
          StreamBuilder<Response<UserDetails>>(builder: (context,snapshot){

            if(snapshot.hasData){

              switch(snapshot.data.status){

                case Status.LOADING:
                // TODO: Handle this case.
                  return Container(child: Center(child: CircularProgressIndicator()));
                case Status.COMPLETED:
                  return getMainContent(snapshot.data.data.data);
                case Status.ERROR:

                  return Container();
              }

            }
            return Container();



          },stream: _appBloc.userDetailsBloc.streamControllerStream)
        ],
      )

    );
  }

  void removeTask(int value){
    print('true $value');
    if(value==0){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pop();
      });
    }
    //Navigator.pop(context);
  }

  Widget getMainContent(Data data){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Id: ${data.id}',style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Name: ${data.firstName} ${data.lastName}',style: TextStyle(fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Email: ${data.email}',style: TextStyle(fontSize: 18),),
        ),

      ],
    );
  }
}