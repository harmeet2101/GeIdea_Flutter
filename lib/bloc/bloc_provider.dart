import 'package:flutter/cupertino.dart';
import 'package:geideaflutter/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget{

  final T bloc;
  final Widget child;

  BlocProvider({Key key,@required this.bloc,@required this.child}):super(key:key);


  static T of<T extends Bloc>(BuildContext context){

      final type = _provideType<BlocProvider<T>>();
      final BlocProvider<T> _blocProvider =context.ancestorWidgetOfExactType(type);
      return _blocProvider.bloc;
  }

  static Type _provideType<T>()=>T;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BlocProviderState();
  }
}

class BlocProviderState extends State<BlocProvider>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
}