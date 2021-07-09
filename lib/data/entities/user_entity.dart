import 'package:list_pessoas/data/entities/telefone_entity.dart';
import 'package:list_pessoas/externals/database_helper.dart';

class UserEntity {
  String name;
  String document;
  int id;
  List<TelefoneEntity> telefones = [];
  UserEntity({
    required this.name,
    required this.document,
    required this.id,
    required this.telefones,
  });

  factory UserEntity.fromMap(Map<String, dynamic> newUser, {List<Map<String, dynamic>> rawPhones = const []}) {
    List<TelefoneEntity> phones = [];
    rawPhones.forEach((rawPhone) {
      phones.add(TelefoneEntity.fromMap(rawPhone));
    });

    return UserEntity(
        name: newUser[DatabaseHelper.userName], document: newUser[DatabaseHelper.userDocument], id: newUser[DatabaseHelper.userId], telefones: phones);
  }
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      DatabaseHelper.userName: name,
      DatabaseHelper.userDocument: document,
    };
  }

  @override
  String toString() {
    return "UserEntity (id: $id, name: $name, document: $document, phones: $telefones)";
  }
}
