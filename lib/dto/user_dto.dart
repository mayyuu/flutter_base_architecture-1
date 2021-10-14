import 'package:flutter_base_architecture/dto/base_dto.dart';

class UserDto extends BaseDto {
  String name="";
  num _id=-1;

  UserDto(this._id, {required this.name});

  UserDto.map(dynamic obj) {
    this.name = obj["name"];
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    return map;
  }
}
