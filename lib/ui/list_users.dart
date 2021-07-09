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
    print("Color: ${Theme.of(context).accentColor}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de pessoas'),
        actions: [
          GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Atualização do usuário'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("ok", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)))
                        ],
                        content: Text("Para atualizar ou ver os dados do usuário clique sobre o card"),
                      );
                    });
              },
              child: Container(margin: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.info)))
        ],
      ),
      body: Observer(
        builder: (BuildContext context) {
          print(usersController.users);
          return ListView.builder(
              itemCount: usersController.users.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    title: Text(usersController.users[index].name),
                    subtitle: Text("Document: ${usersController.users[index].document}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateUserPage(index, usersController)),
                      );
                    },
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Tem certeza que quer deletar o usuário?'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("não", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await usersController.deleteUserAndPhone(usersController.users[index].id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("sim", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)))
                                ],
                              );
                            });
                      },
                      child: Icon(Icons.delete, color: Color(0xffed0909)),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: GestureDetector(
          onTap: () {},
          child: Icon(Icons.add),
        ),
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
