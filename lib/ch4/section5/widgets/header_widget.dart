import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<String> choices = [
  '신고', '알림 설정', '링크 복사'
];

class HeaderWidget extends StatelessWidget {
  void select(String choice){//popup menu click event callback.. 매개변수는 선택한 menu 문자열..
    //toast.....
    Fluttertoast.showToast(
      msg: choice,
      //아래 설정은 플랫폼에 따라 적용안될 수도 있다..
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('images/lab_instagram_icon_0.jpg'),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Text('instagram', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ),

        //여백만 확장시키는 위젯..
        Spacer(),

        PopupMenuButton<String>(
          onSelected: select, //메뉴 선택 이벤트..
          itemBuilder: (context){//메뉴를 구성하기 위해서 자동 호출..
            return choices.map<PopupMenuItem<String>>((String choice){//함수 3번 호출.. 리턴3개..
              return PopupMenuItem<String>(
                value: choice, //이벤트 콜백에 전달될 문자열..
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}