import 'package:list_pessoas/entities/user_entity.dart';
import 'package:list_pessoas/repositories/users_repository.dart';
import 'package:mobx/mobx.dart';

part 'users_controller.g.dart';

class UsersController = UsersControllerBase with _$UsersController;

abstract class UsersControllerBase with Store {
  UsersRepository userRepo = UsersRepository(users: []);

  UsersControllerBase() {
    userRepo.seed();
  }
  @observable
  List<UserEntity> users = [];

  @action
  getUsers() async {
    users = await userRepo.getUsers();
  }

  @action
  registerUser(UserEntity user, List<TelefoneEntity> phones) async {
    await userRepo.insertUserAndPhones(user, phones);
    // userRepo.insertUser(user);
  }

  @action
  updateUser(UserEntity user) async {
    await userRepo.updateUserByIndex(user: user);
    users = await userRepo.getUsers();
  }

  @action
  deleteUserAndPhone(int index) async {
    await userRepo.deleteUserByIndex(index);
    users = await userRepo.getUsers();
  }
}
