import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_pessoas/controllers/users_controller.dart';
import 'package:list_pessoas/entities/user_entity.dart';

class ShowUserInfo extends StatelessWidget {
  final UserEntity user;
  UsersController userController;

  ShowUserInfo(this.user, this.userController) : super();

  TextEditingController nameController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  List<RegisterUserData> fields = [];

  @override
  Widget build(BuildContext context) {
    nameController.text = user.name;
    documentController.text = user.document;
    fields = [];
    user.telefones.forEach((e) {
      fields.add(RegisterUserData(TextEditingController(text: e.number), e.id));
    });

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
                        ElevatedButton(onPressed: () {}, child: Text('Cancelar')),
                        ElevatedButton(
                            onPressed: () {
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
                              userController.updateUser(newUser);
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

class RegisterUserData {
  int id;
  TextEditingController controller;
  late Widget registerField;
  RegisterUserData(this.controller, this.id) {
    registerField = TextFormField(
      controller: this.controller,
      decoration: InputDecoration(hintText: "Telefone"),
    );
  }

  String getData() {
    return controller.text;
  }
}
