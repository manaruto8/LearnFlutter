
import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

void main(){
  //_下划线开头命名表示私有
  //数据类型
  //_dataType();
  //_list();
  //_set();
  //_map();
  //条件语句
  //_judege();
  //可选参数
  //_optional1(123,"a");
  //_optional2(123,k:"a");
  //内嵌函数
  //_nested();
  //闭包
  //print(_closure());
  //print(_closure());
  //print(_closure());
  //运算符
  //_cal();
  //类
  //_class();
  //future用法
  //_future();
  //stream用法
  //_stream();
  //async/await用法
  //_task();
}

void _task() {
  task()async{
    String id=await login("e", "f");
    String userInfo=await getUserInfo(id);
    await saveUserInfo(userInfo);
  }
  task();
}

void _stream() {
  Stream.fromFutures([
    Future.delayed(Duration(seconds: 3),(){
      print("Stream1 start ");
      //throw AssertionError("111");
    }),
    Future.delayed(Duration(seconds: 5),(){
      print("Stream2 start ");
      //throw AssertionError("111");
    })
  ]).listen((event) {
    print(event);
  });
}

void _future() {
  Future.wait([
    Future.delayed(Duration(seconds: 3),(){
      print("delayed1 start ");
      //throw AssertionError("111");
    }),
    Future.delayed(Duration(seconds: 5),(){
      print("delayed2 start ");
      //throw AssertionError("111");
    })
  ]).then((value) => {
    print("then end $value")
  },onError: (error)=>{
    print("onError $error")
  }).catchError((error)=> {
    print("catchError $error")
  }).whenComplete(() => {
    print("whenComplete over")
  });
  //嵌套回调
  login("a","b").then((value) => {
    getUserInfo(value).then((value) => {
      saveUserInfo(value)
    })
  });

  //消除嵌套
  login("c","d").then((value){
    return getUserInfo(value);
  }).then((value){
    return saveUserInfo(value);
  });
}

Future<String> login(String userName, String pwd){
  Completer<String> completer=Completer();
  completer.complete("$userName $pwd login");
  print("$userName $pwd login");
  return completer.future;
}

Future<String> getUserInfo(String id){
  Completer<String> completer=Completer();
  completer.complete("$id getUserInfo");
  print("$id getUserInfo");
  return completer.future;
}

Future saveUserInfo(String userInfo){
  Completer<String> completer=Completer();
  completer.complete("$userInfo saveUserInfo");
  print("$userInfo saveUserInfo");
  return completer.future;
}

void _class() {
  var p=Person();
  p..eat()..drink();
  print(p.name);
  print(p._age);
  p.name="hahaha";
  p._age=20;
  print(p.name);
  print(p._age);
  try {
    (p as Man).eat();
  }catch(e){
    print(e.toString());
  }
  var man=Man();
  (man as Person).eat();
}

class Person implements Doctor,Teacher{
  var name="xyz";
  var _age=18;
  static int n=1;

  void eat(){
    print("eat");
  }

  void drink(){
    print("drink");
  }

  @override
  void teach() {

  }

  @override
  void surgery() {

  }
}

class Man extends Person{
  var x ="X";

  @override
  void eat() {
    // TODO: implement eat
    super.eat();
    print("man eat");
  }

  void work(){
    print("man work");
  }
}

class Woman extends Person{
  var y ="Y";
  void work(){
    print("woman work");
  }

  @override
  void drink() {
    // TODO: implement drink
    super.drink();
    print("woman drink");
  }
}

abstract class Doctor{
  void surgery();
}

abstract class Teacher{
  void teach();
}

void _cal() {
  print(2+3);
  print(2+3.1);
  print(2-3);
  print(2-3.1);
  print(2*3);
  print(2*3.1);
  print(2/3);
  print(2/3.1);
  print(2%3);
  print(2%3.1);
  //print(2 as double);
  //print(3.1 as int);
  print(2 is int);
  print(2 is! int);
  print(3.1 is double);
  print(3.1 is! double);
}

var _closure=(){
  var n=0;
  print("_closure $n");
  return (){
    return ++n;
  };
}();

void _nested() {
  var i=0;
  var k=(x,y){
    i++;
    print("$i $x $y");
  }(0,1);
  k(1,2);
  k(2,3);
}

var x="X";
void _optional1(int i,[j,k]) {
  var x="x";
  //print();
  print(x);
  print(i);
  print(j);
  print(k);
}
void _optional2(int i,{j,k}) {
  var x="x";
  print(i);
  print(j);
  print(k);
}

void _judege(){
  var num=Random().nextInt(3);
  print("num=$num");
  if(num%2==0){
    print("111");
  }else{
    print("222");
  }
  switch(num){
    case 0:
      print("a");
      break;
    case 1:
      print("b");
      break;
    case 2:
      print("c");
    case 3:
      print("d");
    default:
      print("xyz");
      break;
  }
  for(int i=0;i<10;i++){
    num+=i;
    print("i=$i num=$num");
  }
  do{
    num--;
    print("num=$num");
  }while(num>=1);

  print("num=$num");
}

void _map(){
  Map<int,String> map1={
    1:"a",
    2:"b",
    3:"c",
  };
  Map<int,String> map2={
    9:"z",
    8:"y",
    7:"x",
  };
  map1[1]="1";
  print("$map1 ${map1.length}");
  map1[4]="d";
  print("$map1");
  map1.addAll(map2);
  print("addAll $map1");
  map1.remove(4);
  print("remove $map1");

  map1.forEach((key, value) {
    print("$key $value");
  });

  var moji1="\u2665";
  var moji2="\u{1f600}";
  print("$moji1 $moji2");
}

void _set(){
  Set<String> set1={"a","b","c","d"};
  var set2={};
  var set3;
  set1.add("e");
  print("add $set1 ${set1.length}");
  set1.addAll({"x","y","z"});
  print("addAll $set1");
  set1.remove("e");
  print("remove $set1");
  set1.removeAll({"x","z"});
  print("removeAll $set1");

  var constSet1=const {"a","b","c","d"};
  //constSet1.add("e");
  const constSet2={"a","b","c","d"};
  //constSet2.add("e");
}


void _list(){
  List list1=["a","b","c","d"];
  var list2=[];
  var list3;
  list1[0]="0";
  list1.add("e");
  print("add $list1 ${list1.length}");
  list1.insert(1,"1");
  print("insert $list1");
  list1.insertAll(2, [2,3]);
  print("insertAll $list1");
  list1.remove("e");
  print("remove $list1");
  list1.removeAt(1);
  print("removeAt $list1");
  list1.replaceRange(1, 2, ["x","y","z"]);
  print("replaceRange $list1");
  //...扩展运算符 ...?空值感知扩展运算符 将多个元素插入集合
  var list4=["z",...list1,...list2,...?list3];
  print(list4);
  //常量列表，不能修改
  var condtList=const ["a","b","c"];
  //condtList.add("d");
  print(condtList);
  int tag=2;
  var num1=[
    "1","2","3",
    if(tag==2) "4",
  ];
  print(num1);
  var num2=[
    for(var i in num1) "666$i"
  ];
  print(num2);
}

void _dataType(){
  //数字类型-整数
  var n=100;
  int num;

  //数字类型-双精度
  var d=10.3;
  double db;
  //字符串
  var s="abc";
  String str;
  String newLine="""
  nncnansnacn
  ajdprpemfmcn
  hoieoqwkw""";

  //布尔类型
  var b=true;
  bool boo;
  //数组List
  var l=[1,2,3];
  List list;
  //const定义常量,编译已经确定
  const date1=1;
  //final需要运行才知道
  final date2=DateTime(2023,06,16);

  print(newLine);
  print(l);
  print(date2);

  print("string转int: ${int.parse("123")}");
  print("string转double: ${double.parse("123.4")}");
  print("int转string: ${1.toString()}");
  print("int转double: ${1.toDouble()}");
  print("double转string: ${1.1.toString()}");
  print("double转int: ${1.1.toInt()}");
}