import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/entities/user_entity.dart';

class RegisterAuth extends StatefulWidget {
  final UsersController usersController;
  RegisterAuth(this.usersController);

  @override
  _RegisterAuthState createState() => _RegisterAuthState();
}

class _RegisterAuthState extends State<RegisterAuth> {
  List<RegisterUserData> fields = [RegisterUserData(TextEditingController())];
  TextEditingController nameController = TextEditingController();
  TextEditingController documentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Center(
          child: Container(
        width: screenSize.width * 0.8,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(
              "Registro",
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Nome"),
                )),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: documentController,
                  decoration: InputDecoration(hintText: "Documento"),
                )),
            Container(
              height: screenSize.height * 0.1,
              child: Row(
                children: [
                  Text(
                    "Telefone",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        fields.add(RegisterUserData(TextEditingController()));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      decoration:
                          BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(8)),
                      width: 35,
                      height: 35,
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: fields.map((e) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: e.registerField,
                );
              }).toList(),
            ),
            ElevatedButton(
              child: Text("Register"),
              onPressed: () async {
                // print("User: name ${nameController.text} document ${documentController.text} ");
                UserEntity user =
                    UserEntity(name: nameController.text, document: documentController.text, id: 0, telefones: []);
                List<TelefoneEntity> phones = [];
                fields.forEach((field) {
                  phones.add(TelefoneEntity(number: field.getData(), id: user.id, userId: user.id));
                  print("Phone: ${field.getData()}");
                });
                await widget.usersController.registerUser(user, phones);
                await widget.usersController.getUsers();
              },
            )
          ],
        )),
      )),
    );
  }
}

class RegisterUserData {
  TextEditingController controller;
  late Widget registerField;
  RegisterUserData(this.controller) {
    registerField = TextFormField(
      controller: this.controller,
      decoration: InputDecoration(hintText: "Telefone"),
    );
  }

  String getData() {
    return controller.text;
  }
}
