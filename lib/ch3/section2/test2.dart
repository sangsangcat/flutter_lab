//State 의 LifeCycle 테스트...

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ParentWidget());
}

//화면 단위 위젯을 Stateful 로 만드는 것은 바람직하지 않다.. 테스트 떄문에..
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}

class ParentState extends State<ParentWidget> {
  bool isInColumnA = true; //하위 위젯이 어느 위치에 있는지를 판단하기 위해서...ColumnA ? ColumnB ? 구조 변경에 의한 하위 위젯의
  String label = "Label A"; //출력되는 데이터.. 데이터 변경에 의한 하위 위젯의 라이프사이클..

  @override
  Widget build(BuildContext context) {
    final child = ChildWidget(label: label);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Test',),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      //build 가 다시 호출 된다.. 그러면 모든 하위의 위젯이 다시 생성된다..
                      isInColumnA = !isInColumnA; //하위 위젯의 구조 변경..
                    });
                  },
                  child: Text(isInColumnA ? 'Go Column B' : 'Go Column A'),
              ),
              //공간만 차지하는 위젯..
              SizedBox(height: 12,),

              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      label = label == 'Label A' ? 'Label B' : 'Label A';
                    });
                  },
                  child: Text('label 변경'),
              ),

              SizedBox(height: 24,),

              //Column A.......
              //화면에 나오는 다양한 설정..
              Container(
                padding: EdgeInsets.all(12), //4방향 모두.. 12 padding..
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isInColumnA ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text('Column A'),
                    SizedBox(height: 8,),
                    if(isInColumnA) child
                  ],
                ),
              ),

              SizedBox(height: 16,),

              //Column B.......
              Container(
                padding: EdgeInsets.all(12), //4방향 모두.. 12 padding..
                decoration: BoxDecoration(
                  border: Border.all(
                    color: !isInColumnA ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text('Column B'),
                    SizedBox(height: 8,),
                    if(!isInColumnA) child
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  final String label;
  ChildWidget({required this.label}){
    print('ChildWidget constructor... $label');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}

//WidgetsBindingObserver : 앱의 라이프사이클 감지하기 위해서..
class ChildState extends State<ChildWidget> with WidgetsBindingObserver{
  ChildState(){
    print('ChildState constructor...');
  }
  @override
  void initState() {
    super.initState();
    //최초 한번..
    //상태 초기화.. 이벤트 등록..
    //앱의 라이프사이클 변경 순간의 이벤트.. 콜백 함수 등록해야 한다..
    WidgetsBinding.instance.addObserver(this);
    print('ChildState initState...');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //initState 호출 후 바로 호출.. 그 다음 다시 호출되지는 않는데..
    //조상 중에 InheritedWidget 있다면.. 그 InheritedWidget 의 상태가 변경되는 경우에 한해서.. 다시 호출..
    print('ChildState didChangeDependencies...');
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //상위에 의해 자신의 위젯이 다시 생성된 경우...
    print('ChildState didUpdateWidget... old=${oldWidget.label}, new=${widget.label}');
  }

  @override
  Widget build(BuildContext context) {
    print('ChildState build...');
    return Text('label : ${widget.label}', style: TextStyle(fontSize: 16),);
  }

  @override
  void dispose() {
    super.dispose();
    //상태 객체 소멸..
    //이벤트 등록 해제..
    WidgetsBinding.instance.removeObserver(this);
    print('ChildState dispose...');
  }

  //app lifecycle 변경 callback...
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        print('AppLifecycle...resume...');
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      print('AppLifecycle...hidden...');
      break;
    }
  }
}

//최초 화면 출력 순간............
// I/flutter (30562): ChildWidget constructor... Label A
// I/flutter (30562): ChildState constructor...
// I/flutter (30562): ChildState initState...
// I/flutter (30562): ChildState didChangeDependencies...
// I/flutter (30562): ChildState build...

//상위 데이터가 변경이 되어.. 위젯이 다시 생성되는 경우....
//위젯의 생성자는 호출되었다.. 위젯의 상태 생성자는 호출되지 않았다..
//모든 위젯은 불변이다.. 화면 갱신되면 모두 다시 생성된다..
//State 객체는 화면갱신시마다 다시 생성되지 않는다.. 한번 생성 후 메모리에 지속된다..
// I/flutter (30562): ChildWidget constructor... Label B
// I/flutter (30562): ChildState didUpdateWidget... old=Label A, new=Label B
// I/flutter (30562): ChildState build...

//위젯의 트리 구조가 변경된다면..
//위젯도 다시 생성되었지만.. 위젯의 상태도 다시 생성되었다..
//동일 위젯을 이용한다고 하더라도.. 위젯의 구조가 변경되면.. 새로운 위젯으로 인지가 된다..
//상태를 다시 만들게 되어 있다..
//구조가 변경되었을 때 상태를 유지하려면 key 이용해야 한다..
// I/flutter (30562): ChildWidget constructor... Label B
// I/flutter (30562): ChildState constructor...
// I/flutter (30562): ChildState initState...
// I/flutter (30562): ChildState didChangeDependencies...
// I/flutter (30562): ChildState build...
// I/flutter (30562): ChildState dispose...

//앱의 라이프사이클...
// I/flutter (30562): AppLifecycle...hidden...
// I/flutter (30562): AppLifecycle...resume...