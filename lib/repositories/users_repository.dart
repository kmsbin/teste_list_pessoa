import 'package:list_pessoas/entities/user_entity.dart';
import 'package:list_pessoas/externals/database_helper.dart';

class UsersRepository {
  List<UserEntity> users;
  DatabaseHelper dbConn = DatabaseHelper.instance;

  UsersRepository({
    required this.users,
  });

  void seed() {
    // dbConn.insertUser(UserEntity(name: "name", document: "document", id: 0).toMap());
    // dbConn.insertUser(UserEntity(name: "name", document: "document", id: 0).toMap());

    // var user = UserEntity(name: "name", document: "document", id: 0, telefones: []);
    // this.insertUserAndPhones(user, [
    //   TelefoneEntity(number: "3456", id: user.id),
    //   TelefoneEntity(number: "34sdfdgh56", id: user.id),
    // ]);
  }

  Future<void> deleteUserByIndex(int index) async {
    await dbConn.deleteUser(index);
    await dbConn.deletePhone(index);
  }

  void insertUser(UserEntity user) {
    dbConn.insertUser(user.toMap());
  }

  Future<void> insertUserAndPhones(UserEntity newUser, List<TelefoneEntity> phones) async {
    int? userId = await dbConn.insertUser(newUser.toMap());
    print("Insert phone $phones in $userId ");
    phones.forEach((phone) async {
      await dbConn.insertPhone(phone.toMap(), userId!);
    });
  }

  Future<void> updateUserByIndex({
    required UserEntity user,
  }) async {
    await dbConn.updateUser(user.toMap(), user.id);
    for (TelefoneEntity phone in user.telefones) {
      await dbConn.updatePhone(phone.toMap(), phone.id);
    }
  }

  Future<List<UserEntity>> getUsers() async {
    List<Map<String, dynamic>> listUsers = await dbConn.queryAllUsers();
    List<UserEntity> users = [];
    for (var newUser in listUsers) {
      List<Map<String, dynamic>> listPhones = await dbConn.queryAllUserPhones(newUser[DatabaseHelper.userId]);
      users.add(UserEntity.fromMap(newUser, rawPhones: listPhones));
    }
    return users;
  }

  Future<UserEntity> getUserByIndex(int index) async {
    return UserEntity.fromMap(await dbConn.queryUserById(index));
  }
}
