import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FormTestScreen());
  }
}

class FormTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormTestScreenState();
  }
}

class FormTestScreenState extends State<FormTestScreen> {
  //Form 위젯에 설정할 키 준비..
  //필요 순간.. 이 키를 이용해 Form 위젯의 State 를 획득..
  //획득한 State 의 함수를 호출해서 명령을 내리기 위해서...
  //key 로 State 객체를 획득하려면 GlobalKey 로 준비해야 한다.. LocalKey 는 불가하다..
  //GlobalKey 를 준비하면서 제네릭 정보를 주는 이유는 타입 문제로..
  //제네릭 정보가 없으면.. 반환되는 State 타입이 State<StatefulWidget> 타입이어서 우리가 직접 캐스팅 해야 해서...
  var formKey = GlobalKey<FormState>();

  //유저 입력 데이터 저장할 변수..
  String? firstName;
  String? lastName;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Test')),
      body: Column(
        children: [
          //유저 입력 여러개를 Form 으로 감싸서..
          Form(
            key: formKey,
            child: Column(
              children: [
                //유저 입력 요소.. Form 과 상호 작용이 필요해서..
                //TextField, Checkbox 는 안되고..
                //FormField<String> 형태로 준비해야 한다..
                //제네릭 타입 : 값의 타입..
                FormField<String>(
                  initialValue: '',
                  //FormState 의 validate() 함수가 호출되면 자동 호출..
                  //매개변수는 현재 유저 입력 데이터..
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      //invalid...
                      //에러 메시지 문자열 리턴.. 유저 화면에 출력되는 문자열..
                      return 'firstName 을 입력해 주세요';
                    }
                    return null; //valid
                  },
                  //FormState 의 save() 호출시 자동호출.. 매개변수가 유저 입력 데이터..
                  onSaved: (value) {
                    firstName = value;
                  },
                  builder: (FormFieldState<String> state) {
                    return TextField(
                      onChanged: (value) {
                        state.didChange(value); //FormState 에 입력 값 변경 알림..
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        errorText: state.errorText,
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
                //FormField + TextField => TextFormField
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'lastName 을 입력해 주세요';
                    }
                    return null; //valid
                  },
                  onSaved: (value) {
                    lastName = value;
                  },
                ),
                //FormField + Checkbox
                FormField<bool>(
                  initialValue: false,
                  validator: (value) {
                    if (value != true) {
                      return '동의해야 합니다.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    isChecked = value;
                  },
                  builder: (FormFieldState<bool> state) {
                    //TextField 는 자체에서 에러 메시지가 나올 속성을 가진다..
                    //체크박스를 이용하는 항목 구성 위젯..
                    //네모 - 문자열..
                    return CheckboxListTile(
                      value: state.value ?? false,
                      title: Text('약관 동의'),
                      onChanged: state.didChange,
                      subtitle: state.hasError
                          ? Text(
                              state.errorText!,
                              style: TextStyle(color: Colors.red),
                            )
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),

          ElevatedButton(
              onPressed: (){
                //key 를 이용해서 Form 의 State 획득.. 전체 유효성 검사 진행..
                //validate() 하위의 모든 validator() 함수 호출..
                //전체 null -> true
                //하나라도 문자열 리턴 -> false
                if(formKey.currentState?.validate() ?? false){
                  //전체 valid
                  //FormState 의 save() 호출.. 전체 onSaved() 함수 호출..
                  formKey.currentState?.save();
                  print('$firstName, $lastName, $isChecked');
                }
              },
              child: Text('submit'),
          ),
        ],
      ),
    );
  }
}
