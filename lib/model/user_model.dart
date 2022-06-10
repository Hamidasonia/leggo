class UserModel {
  UserModel({
    this.user,
    this.tokenType,
    this.expiresIn,
    this.token,
    this.refreshToken,
  });

  User? user;
  String? tokenType;
  int? expiresIn;
  String? token;
  String? refreshToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    token: json["token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token_type": tokenType,
    "expires_in": expiresIn,
    "token": token,
    "refresh_token": refreshToken,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePhotoUrl,
  });

  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePhotoUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    profilePhotoUrl: json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "profile_photo_url": profilePhotoUrl,
  };
}
