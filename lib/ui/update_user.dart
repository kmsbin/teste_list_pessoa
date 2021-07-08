import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/widgets.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/entities/user_entity.dart';

// ignore: must_be_immutable
class UpdateUserPage extends StatelessWidget {
  final UserEntity user;
  UsersController userController;

  UpdateUserPage(this.user, this.userController) : super();

  TextEditingController nameController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  List<UpdateUserData> fields = [];

  @override
  Widget build(BuildContext context) {
    fields = [];
    user.telefones.forEach((e) {
      fields.add(UpdateUserData(TextEditingController(text: e.number), e.id));
    });
    nameController.text = user.name;
    documentController.text = user.document;

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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      controller: nameController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      "Document",
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
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      "Phones",
                      style: Theme.of(context).textTheme.headline5,
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
                            child: Text('Cancelar')),
                        ElevatedButton(
                            onPressed: () async {
                              UserEntity newUser = UserEntity(
                                  name: nameController.text,
                                  document: documentController.text,
                                  id: user.id,
                                  telefones: user.telefones);
                              List<TelefoneEntity> phonesEntity = fields.map((e) {
                                return TelefoneEntity(number: e.controller.text, id: e.id, userId: e.id);
                              }).toList();
                              print("USER UPDATE $newUser");
                              print("TELEFONE UPDATE $phonesEntity");
                              newUser.telefones = phonesEntity;
                              await userController.updateUser(newUser);
                              Navigator.of(context).pop();
                            },
                            child: Text('Salvar')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
