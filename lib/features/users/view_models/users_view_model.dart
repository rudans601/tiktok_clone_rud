import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile({
    required UserCredential credential,
    String email = "",
    String name = "",
    String birthday = "",
  }) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      uid: credential.user!.uid,
      email: credential.user!.email ?? email,
      name: credential.user!.displayName ?? name,
      bio: "undefined",
      link: "undefined",
      birthday: birthday,
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!
        .copyWith(hasAvatar: true)); //state에 현재 로그인된 프로필의 아바타만 true로 변경해서 복사
    await _userRepository.updateUser(
        state.value!.uid, {"hasAvatar": true}); //UserRepository에 업데이트 해주기
  }

  Future<void> onUpdateUserBio(String bio) async {
    if (state.value == null) return;
    await _userRepository.updateUserBio(state.value!.uid, {"bio": bio});
  }

  Future<void> onUpdateUserLink(String link) async {
    if (state.value == null) return;
    await _userRepository.updateUserLink(state.value!.uid, {"link": link});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
