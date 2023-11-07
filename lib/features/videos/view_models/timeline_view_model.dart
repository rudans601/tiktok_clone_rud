import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    state = const AsyncValue.loading(); //현재 클래스(AsyncNotifier로 확장한)을 로딩상태로 만듬
    await Future.delayed(const Duration(seconds: 2));

    _list = [
      ..._list,
    ]; //리스트 add를 써봤자 새로 렌더링하지 않아서, 기존 리스트에 있던 것들을 전부 가져온다음 새로운 리스트에 더할예정
    state = AsyncValue.data(
        _list); //AsyncValue.data는 AsyncNotifier안에서 데이터를 새로 넣어주는 함수다. 로딩상태에서 데이터가 들어간 상태로 변경됨
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));

    return _list;
  }
}

final timeLineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
