import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//MainScreen -> UserMain - UserSub1 -> UserSub2
//           -> ProductMain -> ProductSub1 -> ProductSub2

//UserSub2 -> MainScreen(Home 이동)
//UserSub2 -> ProductMain(User 화면을 스택에서 재거시켜서)

void main() {
  runApp(MyApp());
}

//go_router 를 이용한 라우팅 정보 선언..
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MainScreen(),
      //계층 구조 등록이 된다.. 하나의 GoRoute 하위에 다른 GoRoute 등록..
      routes: [
        GoRoute(
          // 상위 + / + 자신
          path: 'user', //  /user
          builder: (context, state) => UserMain(),
          routes: [
            GoRoute(path: 'sub1', builder: (context, state) => UserSub1()),
            GoRoute(path: 'sub2', builder: (context, state) => UserSub2()),
          ],
        ),
        GoRoute(
          // 상위 + / + 자신
          path: 'product', //  /product
          builder: (context, state) => ProductMain(),
          routes: [
            GoRoute(path: 'sub1', builder: (context, state) => ProductSub1()),
            GoRoute(path: 'sub2', builder: (context, state) => ProductSub2()),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      //add.............................
      routerConfig: router,
    );
  }
}

// 공통 네비게이션 버튼 (스택 유지 이동)
Widget _navButton(BuildContext context, String label, String route) {
  return ElevatedButton(
    //Material router 를 이용하는 경우
    // onPressed: () => Navigator.pushNamed(context, route),
    //go_router 를 이용하는 경우..
    //push : go_router 에서 extension 기법으로 BuildContext 에 추가한 함수..
    onPressed: () => context.push(route),
    child: Text(label),
  );
}

// ============================================================
// MainScreen
// ============================================================
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MainScreen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MainScreen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _navButton(context, 'UserMain 으로 이동', '/user'),
            SizedBox(height: 12),
            _navButton(context, 'ProductMain 으로 이동', '/product'),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// UserMain
// ============================================================
class UserMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserMain')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UserMain',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _navButton(context, 'UserSub1 으로 이동', '/user/sub1'),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// UserSub1
// ============================================================
class UserSub1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserSub1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UserSub1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _navButton(context, 'UserSub2 으로 이동', '/user/sub2'),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// UserSub2 - MainScreen, ProductMain 으로 이동 시 스택 초기화
// ============================================================
class UserSub2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserSub2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UserSub2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                //add...............................
                //스택정보 원하는 위치까지 제거..
                context.go('/');
              },
              child: Text('MainScreen 으로 이동'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                //add..........................
                context.go('/');
                context.push('/product');
              },
              child: Text('ProductMain 으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ProductMain
// ============================================================
class ProductMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ProductMain')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ProductMain',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _navButton(context, 'ProductSub1 으로 이동', '/product/sub1'),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ProductSub1
// ============================================================
class ProductSub1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ProductSub1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ProductSub1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _navButton(context, 'ProductSub2 으로 이동', '/product/sub2'),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ProductSub2 - MainScreen, UserMain
// ============================================================
class ProductSub2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ProductSub2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ProductSub2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                //add............................
                context.go('/');
              },
              child: Text('MainScreen 으로 이동'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                //add...........................
                context.go('/');
                context.push('/user');
              },
              child: Text('UserMain 으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
