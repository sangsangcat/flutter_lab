import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc 에 발생시킬 이벤트...
//여러 이벤트를 동일 타입으로 이용하려고..
abstract class CounterEvent {
  int no;

  CounterEvent(this.no);
}

class IncrementEvent extends CounterEvent {
  IncrementEvent(int no) : super(no);
}

class DecrementEvent extends CounterEvent {
  DecrementEvent(int no) : super(no);
}

//Bloc 선언..
//<이벤트 타입, 상태 타입>
class BlocCounter extends Bloc<CounterEvent, int> {
  BlocCounter() : super(0) {
    //상위 생성자 꼭 직접 호출해야 한다.. 매개변수는 상태타입, 초기값..
    //이벤트 발생 감지..
    //IncrementEvent 이벤트가 발생되면 매개변수 등록 함수 호출하라..
    //event : 발생한 이벤트.. 이 곳에서 전달한 데이터 추출..
    //emit : 함수..B/L 실행 후 발생한 상태를 발행하는 함수..
    on<IncrementEvent>((event, emit) {
      //state : Bloc 내에 유지되는 데이터.. 이벤트가 발생하기 전 상태값...
      emit(state + event.no);
    });
    on<DecrementEvent>((event, emit) {
      emit(state - event.no);
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  //이벤트 발생시에 호출.. 상태 발행은 못한다.. 상태와 관련없는 업무 처리가 있다면..
  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
  }

  //이벤트가 발생되었을 때 어떤 이벤트에 어떤 상태가 어떻게 변경되었는지 정보를 전달한다..
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('transition...$transition');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) => BlocCounter(),
          child: MyWidget()
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocCounter blocCounter = BlocProvider.of<BlocCounter>(context);
    //bloc 의 상태를 구독만 하겠다.. BlocBuilder 가 편할 수 있다..
    return BlocBuilder<BlocCounter, int>(
        builder: (context, state){
          return Column(
            children: [
              Text('state : $state'),
              ElevatedButton(onPressed: (){
                //add 함수.. bloc 에서 제공하는 함수.. 이벤트 발생 함수..
                blocCounter.add(IncrementEvent(2));
              }, child: Text('increment')),
              ElevatedButton(onPressed: (){
                blocCounter.add(DecrementEvent(2));
              }, child: Text('increment')),
            ],
          );
        }
    );
  }
}
