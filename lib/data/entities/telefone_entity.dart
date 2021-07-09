import 'package:list_pessoas/externals/database_helper.dart';

class TelefoneEntity {
  int userId;
  int id;
  String number;
  TelefoneEntity({required this.number, required this.id, required this.userId});
  factory TelefoneEntity.fromMap(Map<String, dynamic> phones) {
    return TelefoneEntity(id: phones[DatabaseHelper.phoneId], number: phones[DatabaseHelper.number], userId: phones[DatabaseHelper.userIdPhone]);
  }
  Map<String, dynamic> toMap() {
    return {DatabaseHelper.userIdPhone: id, DatabaseHelper.number: number, DatabaseHelper.userIdPhone: userId};
  }

  @override
  String toString() {
    return "TelefoneEntity( id: $id, number: $number) ";
  }
}
