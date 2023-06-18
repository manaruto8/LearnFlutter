import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "counter":(context)=>CounterWidget(),
        "self":(context)=>ManagerSelfState(),
        "parent":(context)=>ParentState(),
        "newpage":(context){
          return NewPage(text: ModalRoute.of(context)!.settings.arguments.toString());
        },
        
      },
      //state生命周期
      home: CounterWidget(),
      //切换Text state回调方法
      //home: Text("xyz",style: TextStyle(color: Colors.blue),),
      //widget管理自身状态
      //home: ManagerSelfState(),
      //父widget管理子widget状态
      //home: ParentState(),
    );
  }

}

class NewPage extends StatelessWidget{

  NewPage({Key? key,required this.text});

  final String text;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: TextButton(
          child:Text(text.isEmpty?"new page":text),
          onPressed: (){
            Navigator.pop(context,"来自关闭的页面");
          },
        ),
      ),
    );
  }

}


class ParentState extends StatefulWidget{

  const ParentState({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ManagerChildState();
  }
}


class _ManagerChildState extends State<ParentState> {

  bool _change=false;
  String text="new page";

  void _changeText(bool change){
    setState(() {
      _change=!change;
    });
  }

  void _setText(String s){
    setState(() {
      text=s;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              ChildState(change:_change,onChanged: _changeText),
              TextButton(
                child: Text(text),
                onPressed: () async{
                  var result=await Navigator.push(context, MaterialPageRoute(builder: (context){
                    return NewPage(text: "来自上一个页面");
                  }));
                  _setText(result);
                },
              ),
            ]
        )
      ),
    );
  }
}

class ChildState extends StatelessWidget{

  ChildState({Key? key,this.change=false,required this.onChanged});

  final bool change;
  final ValueChanged<bool> onChanged;

  void _changeText(){
    onChanged(change);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Text(change?"3":"4"),
      onTap: _changeText
    );
  }

}

class ManagerSelfState extends StatefulWidget{

  const ManagerSelfState({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ManagerSelfState();
  }

}

class _ManagerSelfState extends State<ManagerSelfState> {

  bool _change=false;

  void _changeText(){
    setState(() {
      _change=!_change;
    });
  }

  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)!.settings.arguments;
    print(args);
    // TODO: implement build
    return Scaffold(
      body: Center(
          child:GestureDetector(
            child: Text(_change?"1":"2"),
            onTap: _changeText
          )
      )
    );

  }
}


class CounterWidget extends StatefulWidget{

  const CounterWidget({super.key,this.count=0});

  final int count;

  @override
  _CounterWidgetState createState() {
    return _CounterWidgetState();
  }

}
/** 初始化 initState -> didChangeDependencies -> build
 *  热重载 reassemble -> didUpdateWidge -> build
 *  更改其它控件 reassemble -> deactivate -> dispose
 */
class _CounterWidgetState extends State<CounterWidget> {

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.count;
    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget ");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child:Column(
          children: [
            TextButton(
              child: Text('$_counter'),
        //点击后计数器自增
              onPressed: () => setState(
                () => ++_counter,
              ),
            ),
            TextButton(
              child: Text("ManagerSelfState"),
              //点击后计数器自增
              onPressed: () => {
                Navigator.pushNamed(context, "self",arguments: "来自Counter")
              },
            ),
            Image.asset('images/x.png')
          ],
        ) 
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }
}