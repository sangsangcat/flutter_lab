import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoScreen());
  }
}

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoScreenState();
  }
}

class TodoScreenState extends State<TodoScreen> {
  final controller = TextEditingController();

  final List<String> todos = [];
  int? editIndex; //수정하고자 하는 항목 index..

  //입력 후 버튼 클릭..
  onSubmit() {
    //유저 입력 데이터 추출...
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      if (editIndex == null) {
        //추가...
        todos.add(text);
      } else {
        //수정...
        todos[editIndex!] = text;
        editIndex = null;
      }
      //유저 입력 문자열 화면에서 제거..
      controller.clear();
    });
  }

  //수정 메뉴 클릭..
  onEdit(int index) {
    //유저가 수정하고자 하는 항목의 문자열을 TextField 에 출력해서 수정할 수 있게..
    setState(() {
      editIndex = index; //몇번째 항목이 수정되는 것인지 유지..
      //TextField 에 자동으로 문자열 출력 (유저 입력한 것이 아닌), controller에게 지정..
      controller.text = todos[index];
    });
  }

  //삭제 메뉴 클릭..
  onDelete(int index) {
    setState(() {
      todos.removeAt(index);
      if (editIndex == index) {
        editIndex = null;
        controller.clear();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo test')),
      body: Column(
        children: [
          Expanded(
            child: todos.isEmpty
                ? Center(
                    child: Text(
                      'Todo를 추가하세요.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      //현재 항목이 선택된 항목인가?
                      final isEditing = editIndex == index;
                      return ListTile(
                        tileColor: isEditing ? Colors.blue : null,
                        leading: CircleAvatar(
                          backgroundColor: isEditing
                              ? Colors.blue
                              : Colors.grey,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isEditing ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          todos[index],
                          style: TextStyle(
                            color: isEditing ? Colors.blue : Colors.black,
                            fontWeight: isEditing
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          onSelected: (result) {
                            if (result == 'update') {
                              onEdit(index);
                            } else if (result == 'delete') {
                              onDelete(index);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'update',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 8),
                                  Text('수정'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 8),
                                  Text('삭제'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: 1, color: Colors.grey);
                    },
                    itemCount: todos.length,
                  ),
          ),
          Container(
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: editIndex == null
                          ? 'Todo를 입력하세요'
                          : '수정할 내용을 입력하세요',
                      prefixIcon: Icon(
                        editIndex == null ? Icons.add : Icons.edit,
                        color: editIndex == null ? Colors.grey : Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => onSubmit(),
                  ),
                ),
                SizedBox(width: 8),
                if (editIndex != null)
                  //수정중이라면.. 전체 입력된 글 지우기 위한 X 버튼 제공..
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        editIndex = null;
                        controller
                            .clear(); //controller 에 수정하기 위한 문자열이 지정되어 있다..
                        //controller 의 문자열을 지워야.. 화면에 문자열이 지워진다..
                      });
                    },
                  ),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: Text(editIndex == null ? '추가' : '수정'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
