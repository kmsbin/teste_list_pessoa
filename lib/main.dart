import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/ui/register_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'list pessoas',
      home: ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UsersController usersController = UsersController();
    usersController.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('list pessoas'),
      ),
      body: Observer(
        builder: (BuildContext context) {
          return ListView.builder(
              itemCount: usersController.users.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(usersController.users[index].name),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterAuth()),
          );
        },
      ),
    );
  }
}
