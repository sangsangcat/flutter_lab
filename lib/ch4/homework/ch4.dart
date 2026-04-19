import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('나의 프로필',),),
      body: SingleChildScrollView( //스크롤 적용 및 전체 패딩
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 프로필 정보
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey,width: 1),
              ),
              child: Row(
                children: [
                  // 프로필 아바타 이미지
                  Image.asset('images/icon/user.png'),
                  SizedBox(width: 20), // 이미지와 텍스트 사이 간격
                  // 이름과 소속 정보 (세로 나열)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '홍길동',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // 텍스트 사이 간격
                      Text(
                        'Flutter 개발자\nSeoul, Korea',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // 통계 카드 섹션
            Row(
              children: [
                //가로로 꽉차게 균등 배분
                Expanded(child: buildStatColumn('42', '게시글')),
                SizedBox(width: 8),
                Expanded(child: buildStatColumn('128', '팔로워')),
                SizedBox(width: 8),
                Expanded(child: buildStatColumn('64', '팔로잉')),
              ],
            ),
            SizedBox(height: 16),

            // 하트 이미지 섹션
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset('images/icon.jpg', fit: BoxFit.contain),
                  ),
                ),
                SizedBox(width: 8),

                Expanded(
                  child: Container(
                    child: Image.asset('images/icon.jpg', fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 자기소개 섹션
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey,width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '자기소개',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '안녕하세요! Flutter를 공부하고 있는 개발자입니다. 모바일 앱 개발에 관심이 많습니다.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 통계 카드 위젯
  Widget buildStatColumn(String count, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}