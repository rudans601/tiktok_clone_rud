import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";
  final SharedPreferences _preferences; //간단한 데이터를 사용자기기 저장소에 persist하는 객체

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value); //_muted에서 읽어서 disk에 value를 저장한다
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value); //_autoplay에서 읽어서 disk에 value를 저장한다
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ??
        false; //음소거 데이터를 읽는다. 디스크에 데이터가 없으면 false반환
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ??
        false; //자동재생 데이터를 읽는다. 디스크에 데이터가 없으면 false반환
  }
}
