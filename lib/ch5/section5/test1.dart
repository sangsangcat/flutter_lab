import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //bottomNavigationBar의 item 선택 정보..
  int selectedIndex = 0;

  //bottomNavigationBar의 item 클릭시 나올 화면 위젯..body 에 출력될 위젯..
  List<Widget> widgets = [
    Text('One', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    Text('Two', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    Text('Three', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    Text('Four', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
  ];

  //bottomNavigationBar, item 클릭 이벤트 콜백..
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          //appbar 하단에 위치시킬 위젯..
          //PreferredSize - 상위 위젯에게 나를 위해서 어느정도 사이즈가 확보되어야하는지를 요청하는 위젯이다..
          //AppBar 가 PreferredSize 의 preferredSize 값을 참조하게 되어 있다..
          //자식이 -> 부모에게 자신을 위한 사이즈를 알려준다는 개념..
          //Container -> Text 구조로 위젯을 준비..대부분의 경우 자식이 먼저 초기화 되어서.. 사이즈가 결정되고
          //그 사이즈 값을 참조해서 부모가 사이즈를 잡는다..
          //Scaffold 가 화면의 기본 구조를 구성하는 위젯이다 보니.. 먼저 구조 구성.. 즉 AppBar 가 어느 정도 사이즈여야
          //할지를 먼저 결정하게 된다.. 그러다보니 자식이 초기화 되기 전에 너는 어느정도 사이즈가 필요하는지 물어봐야한다.
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: Text('AppBar Bottom Text'),
            ),
          ),
          //appbar 가 어느정도 사이즈를 확보할 지 모르지만.. appbar 가장 하단(background) 에 위젯 위치..
          //z 축으로 가장 아래 부분..
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/big.jpeg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text('AppBar Title'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_alert)),
            IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          ],
        ),
        body: widgets.elementAt(selectedIndex),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          //item 클릭시 애니메이션 효과 적용 - shifting, fixed(없다)
          items: [
            //backgroundColor : 이 item 이 클릭되었을 때..BottomNavigationBar 의 전체 background color
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'One',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Two',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Three',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Four',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: selectedIndex,
          //현재 선택된 item..
          selectedItemColor: Colors.amber,
          //선택된 item 의 색상..
          onTap: onItemTapped, //이벤트..
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(title: Text('Item 1'), onTap: (){ },),
              ListTile(title: Text('Item 2'), onTap: (){ },),
              ListTile(title: Text('Item 3'), onTap: (){ },),
            ],
          ),
        ),
      ),
    );
  }
}
