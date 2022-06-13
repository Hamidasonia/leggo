class UserModel {
  UserModel({
    this.data,
  });

  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.insertUsers,
  });

  InsertUsers? insertUsers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        insertUsers: InsertUsers.fromJson(json["insert_users"]),
      );

  Map<String, dynamic> toJson() => {
        "insert_users": insertUsers?.toJson(),
      };
}

class InsertUsers {
  InsertUsers({
    this.returning,
  });

  List<Returning>? returning;

  factory InsertUsers.fromJson(Map<String, dynamic> json) => InsertUsers(
        returning: List<Returning>.from(
            json["returning"].map((x) => Returning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "returning": List<dynamic>.from(returning!.map((x) => x.toJson())),
      };
}

class Returning {
  Returning({
    this.id,
    this.email,
    this.username,
    this.fullname,
    this.password,
    this.tglDaftar,
  });

  int? id;
  String? email;
  String? username;
  String? fullname;
  String? password;
  DateTime? tglDaftar;

  factory Returning.fromJson(Map<String, dynamic> json) => Returning(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        fullname: json["fullname"],
        password: json["password"],
        tglDaftar: DateTime.parse(json["tgl_daftar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "fullname": fullname,
        "password": password,
        "tgl_daftar":
            "${tglDaftar?.year.toString().padLeft(4, '0')}-${tglDaftar?.month.toString().padLeft(2, '0')}-${tglDaftar?.day.toString().padLeft(2, '0')}",
      };
}
