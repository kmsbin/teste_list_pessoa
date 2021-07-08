import 'package:list_pessoas/entities/user_entity.dart';
import 'package:list_pessoas/externals/database_helper.dart';

class UsersRepository {
  List<UserEntity> users;
  DatabaseHelper dbConn = DatabaseHelper.instance;

  UsersRepository({
    required this.users,
  });

  void seed() {
    dbConn.insertUser(UserEntity(name: "name", document: "document", id: 0, telefones: [TelefoneEntity(number: '3456')]).toMap());
    dbConn.insertUser(UserEntity(name: "name", document: "document", id: 0, telefones: [TelefoneEntity(number: '3456')]).toMap());
    dbConn.insertUser(UserEntity(name: "name", document: "document", id: 0, telefones: [TelefoneEntity(number: '3456')]).toMap());
    dbConn.insertUser(UserEntity(name: "name", document: "document", id: 0, telefones: [TelefoneEntity(number: '3456')]).toMap());
  }

  void deleteUserByIndex(int index) async {
    dbConn.deleteUser(index);
  }

  void insertUser(UserEntity user) {
    users.add(user);
  }

  void updateUserByIndex({required UserEntity user}) {
    dbConn.updateUser(user.toMap(), user.id);
  }

  Future<List<UserEntity>> getUsers() async {
    List<Map<String, dynamic>> listUsers = await dbConn.queryAllUsers();
    List<UserEntity> users = [];
    listUsers.forEach((newUser) {
      users.add(UserEntity.fromMap(newUser));
    });
    return users;
  }

  Future<UserEntity> getUserByIndex(int index) async {
    return UserEntity.fromMap(await dbConn.queryUserById(index));
  }
}
