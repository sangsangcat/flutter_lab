import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Image Test'),),
        //위젯이 나열하다가 화면을 벗어나게 되면..자동 스크롤 지원하지 않는다..
        //검정색 - 노란색.. 경고 패턴이 출력된다..
        //SingleChildScrollView - 자식 위젯이 하나이고.. 그 자식 위젯 부분을 스크롤 할 때..
        //ListView - 자식이 여러개..여러개를 한꺼번에 스크롤 할때..
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Image + ImageProvider 조합..
              Image(image: NetworkImage('https://picsum.photos/300/200'),),
              //사이즈를 변경해서..종횡비 유지 별도의 방법은 없다.. 단일 방향 사이즈만 지정하면..
              //종횡비 유지해서 그 사이즈로 변경된다..
              Image(image: ResizeImage(NetworkImage('https://picsum.photos/300/200'), width: 150),),
              //named constructor 이용..
              Image.network('https://picsum.photos/300/200'),
              Image.asset('images/big.jpeg',),
              //화면의 특정 영역의 설정...
              //Image 위젯이 차지하는 영역을 확인하기 위해서..
              Container(
                color: Colors.red,
                child: Image.asset(
                  'images/big.jpeg',
                  width: 200,
                  height: 100,
                  // fit: BoxFit.fill, //위젯 전체에 모든 이미지 출력. 종횡비가 변경될 가능성
                  // fit: BoxFit.contain, //이미지 전체 출력.. 여백 발생 가능성..
                  fit: BoxFit.cover, //여백은 발생하지 않는다. 이미지 잘릴 수 있다..
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}