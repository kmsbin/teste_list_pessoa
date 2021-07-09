import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:list_pessoas/data/entities/telefone_entity.dart';
import 'package:list_pessoas/util.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/data/entities/user_entity.dart';

// ignore: must_be_immutable
class UpdateUserPage extends StatelessWidget {
  late UserEntity user;
  final int userIndex;
  UsersController userController;

  UpdateUserPage(this.userIndex, this.userController) : super();

  TextEditingController nameController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  List<UpdateUserData> fields = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Observer(builder: (context) {
          user = userController.users[userIndex];
          fields = [];
          userController.users[userIndex].telefones.forEach((e) {
            fields.add(UpdateUserData(TextEditingController(text: e.number), e.id));
          });
          nameController.text = userController.users[userIndex].name;
          documentController.text = userController.users[userIndex].document;
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Nome",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: TextFormField(
                        controller: nameController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Documento",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: TextFormField(
                        controller: documentController,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            "Telefones",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          // ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                          GestureDetector(
                            onTap: () {
                              newDialog(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(8)),
                              width: 35,
                              height: 35,
                              child: Icon(
                                Icons.add,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ...fields.map((e) {
                      return Container(margin: EdgeInsets.only(top: 4), child: e.registerField);
                    }),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                          ElevatedButton(
                              onPressed: () async {
                                UserEntity newUser = UserEntity(
                                    name: nameController.text,
                                    document: documentController.text,
                                    id: userController.users[userIndex].id,
                                    telefones: userController.users[userIndex].telefones);
                                List<TelefoneEntity> phonesEntity = fields.map((e) {
                                  return TelefoneEntity(number: e.controller.text, id: e.id, userId: e.id);
                                }).toList();
                                print("USER UPDATE $newUser");
                                print("TELEFONE UPDATE $phonesEntity");
                                newUser.telefones = phonesEntity;
                                await userController.updateUser(newUser);
                                await userController.getUsers();
                                Navigator.of(context).pop();
                              },
                              child: Text('Salvar', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  newDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();

          return AlertDialog(
            title: Text('Insira Um número de telefone'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("cancelar", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))),
              ElevatedButton(
                  onPressed: () {
                    this.userController.registerPhone(
                        TelefoneEntity(number: controller.text, id: 0, userId: userController.users[userIndex].id), userController.users[userIndex].id);
                    this.userController.getUsers();
                    Navigator.of(context).pop();
                  },
                  child: Text("salvar", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)))
            ],
            content: TextFormField(
              onChanged: (value) {},
              inputFormatters: [Utils.maskFormatter],
              controller: controller,
              decoration: InputDecoration(hintText: "Insira novo telefone"),
            ),
          );
        });
  }
}

class UpdateUserData {
  int id;
  TextEditingController controller;
  late Widget registerField;
  UpdateUserData(this.controller, this.id) {
    var maskFormatter = new MaskTextInputFormatter(mask: ' (##) #####-####', filter: {"#": RegExp(r'[0-9]')});
    registerField = TextFormField(
      inputFormatters: [maskFormatter],
      controller: this.controller,
      decoration: InputDecoration(hintText: "Telefone"),
    );
  }

  String getData() {
    return controller.text;
  }
}
