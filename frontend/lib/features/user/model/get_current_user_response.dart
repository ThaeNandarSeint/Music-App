import 'package:music_app/features/user/model/user_model.dart';

class GetCurrentUserResponse {
  final UserModel user;

  GetCurrentUserResponse({required this.user});

  factory GetCurrentUserResponse.fromJson(Map<String, dynamic> json) {
    return GetCurrentUserResponse(user: UserModel.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson()};
  }
}
