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
    this.users,
  });

  List<User>? users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.fullname,
    this.email,
    this.username,
    this.password,
    this.tglDaftar,
  });

  int? id;
  String? fullname;
  String? email;
  String? username;
  String? password;
  DateTime? tglDaftar;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    tglDaftar: DateTime.parse(json["tgl_daftar"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "email": email,
    "username": username,
    "password": password,
    "tgl_daftar": "${tglDaftar?.year.toString().padLeft(4, '0')}-${tglDaftar?.month.toString().padLeft(2, '0')}-${tglDaftar?.day.toString().padLeft(2, '0')}",
  };
}
