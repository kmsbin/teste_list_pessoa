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

  void deleteUserByIndex(int index) async {
    dbConn.deleteUser(index);
  }

  void insertUser(UserEntity user) {
    dbConn.insertUser(user.toMap());
  }

  void insertUserAndPhones(UserEntity newUser, List<TelefoneEntity> phones) async {
    int? userId = await dbConn.insertUser(newUser.toMap());
    print("Insert phone $phones in $userId ");
    phones.forEach((phone) async {
      await dbConn.insertPhone(phone.toMap(), userId!);
    });
  }

  void updateUserByIndex({required UserEntity user}) {
    dbConn.updateUser(user.toMap(), user.id);
  }

  Future<List<UserEntity>> getUsers() async {
    List<Map<String, dynamic>> listUsers = await dbConn.queryAllUsers();
    List<UserEntity> users = [];
    listUsers.forEach((newUser) async {
      List<Map<String, dynamic>> listPhones = await dbConn.queryAllUserPhones(newUser[DatabaseHelper.userId]);
      users.add(UserEntity.fromMap(newUser, rawPhones: listPhones));
    });
    users.forEach((element) {
      print("Telefones ${element.telefones}");
    });
    return users;
  }

  Future<UserEntity> getUserByIndex(int index) async {
    return UserEntity.fromMap(await dbConn.queryUserById(index));
  }
}
