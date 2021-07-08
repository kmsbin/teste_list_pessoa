import 'package:list_pessoas/entities/user_entity.dart';

class UserRepository {
  UserEntity user;
  UserRepository({
    required this.user,
  });

  UserEntity get getUser => user;

  void updateUser(UserEntity user) {}
}
