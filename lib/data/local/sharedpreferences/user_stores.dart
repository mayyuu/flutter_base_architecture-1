import 'dart:convert';

import 'package:flutter_base_architecture/constants/session_manager_const.dart';
import 'package:flutter_base_architecture/dto/base_dto.dart';
import 'package:flutter_base_architecture/utils/session_manager.dart';

abstract class UserStore<T extends BaseDto> {
  Future<bool> setUser(T userDto) async {
    SessionManager? preference = await SessionManager.getInstance();
    return preference?.setString(const_user, json.encode(userDto.toJson())) ??
        Future.value(false);
  }

  Future<bool> userIsLoggedIn() async {
    var preference = await SessionManager.getInstance();
    return ((preference?.getString(const_user) != null) ? true : false);
  }

  Future<T?> getLoggedInUserJson() async {
    var preference = await SessionManager.getInstance();
    return preference?.getString(const_user) != null
        ? mapUserDto(json.decode(preference?.getString(const_user) ?? ''))
        : null;
  }

  Future<bool> removeUser() async {
    var preference = await SessionManager.getInstance();
    return preference?.remove(const_user)??Future.value(false);
  }

  T mapUserDto(decode);
}

/*class Test extends UserStore<UserDto> {
  @override
  UserDto mapUserDto(decode) {
   return UserDto.map(decode);
  }
}*/
