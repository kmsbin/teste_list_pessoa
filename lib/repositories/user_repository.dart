import 'package:list_pessoas/entities/user_entity.dart';

class UserRepository {
  UserEntity user;
  UserRepository({
    required this.user,
  });

  UserEntity get getUser => user;

  void updateUser({required String name, required String document, required List<TelefoneEntity> telefones}) {
    // user = UserEntity(name: name, document: document, telefones: telefones);
  }
}
