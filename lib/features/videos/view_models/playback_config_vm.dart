import 'package:flutter/foundation.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository; //repository 객체

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    //model 객체
    muted: _repository.isMuted(), //음소거 데이터를 읽는다
    autoplay: _repository.isAutoplay(), //자동재생 데이터를 읽는다
  );

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted; //_model에 접근해서 muted를 반환

  bool get autoplay => _model.autoplay; //_model에 접근해서 autoplay를 반환

  void setMuted(bool value) {
    //viewmodel에서 음소거 세팅 메서드
    _repository.setMuted(value); //repository에서 음소거를 해서 기기 저장소에 저장
    _model.muted = value; //model은 muted값을 value로 저장해줌
    notifyListeners();
  }

  void setAutoplay(bool value) {
    //viewmodel에서 자동재생 세팅 메서드
    _repository.setAutoplay(value); //repository에서 음소거를 해서 기기 저장소에 저장
    _model.autoplay = value; //model은 muted값을 value로 저장해줌
    notifyListeners(); //listen하고 있는 모두에게 notify, 알려줌
  }
}
