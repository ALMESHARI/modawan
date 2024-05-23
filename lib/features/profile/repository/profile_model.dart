class ProfileModel {
  final String userID;
  final String appreaingName;
  final String about;
  final String avatar;
  final bool finishSteup;
  final String username;
  final DateTime createdAt;

  ProfileModel({required this.userID, required this.appreaingName, required this.about, required this.avatar, required this.finishSteup, required this.username, required this.createdAt});

  ProfileModel copyWith({String? userID, String? appreaingName, String? about, String? avatar, bool? finishSteup, String? username, DateTime? createdAt}) {
    return ProfileModel(
      userID: userID ?? this.userID,
      appreaingName: appreaingName ?? this.appreaingName,
      about: about ?? this.about,
      avatar: avatar ?? this.avatar,
      finishSteup: finishSteup ?? this.finishSteup,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userID,
      'appreaing_name': appreaingName,
      'about': about,
      'avatar': avatar,
      'finish_steup': finishSteup,
      'username': username,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }
  // from json 
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userID: map['user_id'],
      appreaingName: map['appreaing_name'],
      about: map['about'],
      avatar: map['avatar'],
      finishSteup: map['finish_steup'],
      username: map['username'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }
  
}
