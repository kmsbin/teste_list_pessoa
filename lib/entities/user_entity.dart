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
        name: newUser[DatabaseHelper.userName],
        document: newUser[DatabaseHelper.userDocument],
        id: newUser[DatabaseHelper.userId],
        telefones: phones);
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

class TelefoneEntity {
  int userId;
  int id;
  String number;
  TelefoneEntity({required this.number, required this.id, required this.userId});
  factory TelefoneEntity.fromMap(Map<String, dynamic> phones) {
    return TelefoneEntity(
        id: phones[DatabaseHelper.phoneId],
        number: phones[DatabaseHelper.number],
        userId: phones[DatabaseHelper.userIdPhone]);
  }
  Map<String, dynamic> toMap() {
    return {DatabaseHelper.userIdPhone: id, DatabaseHelper.number: number, DatabaseHelper.userIdPhone: userId};
  }

  @override
  String toString() {
    return "TelefoneEntity( id: $id, number: $number) ";
  }
}
