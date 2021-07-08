class UserEntity {
  String name;
  String document;
  int id;
  List<TelefoneEntity> telefones;
  UserEntity({
    required this.name,
    required this.document,
    required this.id,
    required this.telefones,
  });

  factory UserEntity.fromMap(Map<String, dynamic> newUser) {
    return UserEntity(
        name: newUser['name'] ?? '', document: newUser['document'], telefones: [TelefoneEntity(number: newUser['telefones'].toString())], id: newUser['id']);
  }
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'document': document,
    };
  }
}

class TelefoneEntity {
  String number;
  TelefoneEntity({
    required this.number,
  });
}
