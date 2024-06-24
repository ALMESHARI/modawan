import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String userID;
  final String? appreaingName;
  final String? about;
  final String? avatar;
  final String? avatarURL;
  final String? username;
  final DateTime createdAt;

  const ProfileModel(
      {required this.userID,
      required this.appreaingName,
      required this.about,
      required this.avatar,
      required this.username,
      required this.createdAt,
      this.avatarURL});

  // getter isCompleted
  bool get isCompleted {
    return appreaingName != null &&
        username != null;
  }

  ProfileModel copyWith(
      {String? userID,
      String? appreaingName,
      String? about,
      String? avatar,
      bool? finishSteup,
      String? username,
      DateTime? createdAt,
      String? avatarURL}) {
    return ProfileModel(
      userID: userID ?? this.userID,
      appreaingName: appreaingName ?? this.appreaingName,
      about: about ?? this.about,
      avatar: avatar ?? this.avatar,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      avatarURL: avatarURL ?? this.avatarURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userID,
      'appearing_name': appreaingName,
      'about': about,
      'avatar': avatar,
      'username': username,
      'created_at': createdAt.toString(),
    };
  }

  // from json
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userID: map['user_id'],
      appreaingName: map['appearing_name'],
      about: map['about'],
      avatar: map['avatar'],
      username: map['username'],
      createdAt: DateTime.parse(map['created_at']),
      avatarURL: map['avatarURL'], // avatarURL stored in cache only
    );
  }

  @override
  List<Object?> get props =>
      [userID, appreaingName, about, avatar, username, createdAt];
}
