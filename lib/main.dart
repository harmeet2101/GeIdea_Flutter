import 'package:flutter/material.dart';
import 'package:geideaflutter/bloc/app_bloc.dart';
import 'package:geideaflutter/bloc/bloc_provider.dart';
import 'package:geideaflutter/rest/Response.dart';
import 'package:geideaflutter/rest/Status.dart';
import 'package:geideaflutter/rest/response/data.dart';
import 'package:geideaflutter/rest/response/user_details.dart';
import 'package:geideaflutter/rest/response/users.dart';
import 'package:geideaflutter/ui/user_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: AppBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   AppBloc _appBloc;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc = BlocProvider.of<AppBloc>(context);
    _appBloc.userBloc.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: StreamBuilder<Response<Users>>(builder: (context,snapshot){

          if(snapshot.hasData){

            switch(snapshot.data.status){

              case Status.LOADING:
              // TODO: Handle this case.
                return Container(child: Center(child: CircularProgressIndicator()));
              case Status.COMPLETED:
                return getListOfUsers(context, snapshot.data.data.data);
              case Status.ERROR:

                return Container();
            }

          }
          return Container();



        },stream: _appBloc.userBloc.streamControllerStream),
      ),
    );
  }

  Widget getListOfUsers(BuildContext buildContext,List<Data> dataList){
     return ListView.builder(itemBuilder: (buildContext,int index){

       return GestureDetector(
         onTap: (){
           Navigator.push(buildContext,
               MaterialPageRoute(builder: (buildContext)=>UserDetailsScreen(userId: dataList[index].id,)));
         },
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Id: ${dataList[index].id}'),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Name: ${dataList[index].firstName} ${dataList[index].lastName}'),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Email: ${dataList[index].email}'),
             ),

           ],
         ),
       );

     },itemCount: dataList.length,);
  }
}
