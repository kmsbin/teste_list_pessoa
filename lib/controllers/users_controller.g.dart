// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsersController on UsersControllerBase, Store {
  final _$usersAtom = Atom(name: 'UsersControllerBase.users');

  @override
  List<UserEntity> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserEntity> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$getUsersAsyncAction = AsyncAction('UsersControllerBase.getUsers');

  @override
  Future getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  final _$registerUserAsyncAction =
      AsyncAction('UsersControllerBase.registerUser');

  @override
  Future registerUser(UserEntity user, List<TelefoneEntity> phones) {
    return _$registerUserAsyncAction
        .run(() => super.registerUser(user, phones));
  }

  final _$registerPhoneAsyncAction =
      AsyncAction('UsersControllerBase.registerPhone');

  @override
  Future registerPhone(TelefoneEntity phone, int userId) {
    return _$registerPhoneAsyncAction
        .run(() => super.registerPhone(phone, userId));
  }

  final _$updateUserAsyncAction = AsyncAction('UsersControllerBase.updateUser');

  @override
  Future updateUser(UserEntity user) {
    return _$updateUserAsyncAction.run(() => super.updateUser(user));
  }

  final _$deleteUserAndPhoneAsyncAction =
      AsyncAction('UsersControllerBase.deleteUserAndPhone');

  @override
  Future deleteUserAndPhone(int index) {
    return _$deleteUserAndPhoneAsyncAction
        .run(() => super.deleteUserAndPhone(index));
  }

  @override
  String toString() {
    return '''
users: ${users}
    ''';
  }
}
