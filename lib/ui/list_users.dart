import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/ui/register_user.dart';
import 'package:list_pessoas/ui/update_user.dart';

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
          print(usersController.users);
          return ListView.builder(
              itemCount: usersController.users.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(usersController.users[index].name),
                  subtitle: Text("Document: ${usersController.users[index].document}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserPage(usersController.users[index], usersController)),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          usersController.deleteUserAndPhone(index);
                        },
                        child: Icon(
                          Icons.update,
                          color: Color(0xfffcba03),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          usersController.deleteUserAndPhone(index);
                        },
                        child: Icon(Icons.delete, color: Color(0xffed0909)),
                      )
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterAuth(usersController)),
          );
        },
      ),
    );
  }
}
