class PermissionsModel {
  PermissionsModel({required this.adminEmails, required this.usernamepool});
  final List<String> adminEmails;
  final List<String> usernamepool;

  PermissionsModel copyWith(
          {List<String>? adminEmails, List<String>? usernamepool}) =>
      PermissionsModel(
          adminEmails: adminEmails ?? this.adminEmails,
          usernamepool: usernamepool ?? this.usernamepool);

  factory PermissionsModel.fromJson(Map<String, dynamic> json) =>
      PermissionsModel(
        adminEmails: List<String>.from(json["emails"].map((x) => x)),
        usernamepool: List<String>.from(json["usernames"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "emails": List<dynamic>.from(adminEmails.map((x) => x)),
        "usernames": List<dynamic>.from(usernamepool.map((x) => x)),
      };
}
