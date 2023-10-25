import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createProfile(UserProfileModel use) async {}
  //프로필 생성
  //프로필 획득
  //아바타 수정
  //바이오 수정
  //링크 수정
}

final userRepo = Provider((ref) => UserRepository());
