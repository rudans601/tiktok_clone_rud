import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository; //repository 객체

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    //viewmodel에서 음소거 세팅 메서드
    _repository.setMuted(value); //repository에서 음소거를 해서 기기 저장소에 저장
    state = PlaybackConfigModel(muted: value, autoplay: state.autoplay);
  }

  void setAutoplay(bool value) {
    //viewmodel에서 자동재생 세팅 메서드
    _repository.setAutoplay(value); //repository에서 음소거를 해서 기기 저장소에 저장
    state = PlaybackConfigModel(muted: state.muted, autoplay: value);
  }

  @override
  PlaybackConfigModel build() {
    // TODO: implement build
    return PlaybackConfigModel(
      //model 객체
      muted: _repository.isMuted(), //음소거 데이터를 읽는다
      autoplay: _repository.isAutoplay(), //자동재생 데이터를 읽는다
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
