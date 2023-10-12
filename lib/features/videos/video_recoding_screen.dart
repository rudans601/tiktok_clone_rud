import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class VideoRecodingScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";
  const VideoRecodingScreen({super.key});

  @override
  State<VideoRecodingScreen> createState() => _VideoRecodingScreenState();
}

class _VideoRecodingScreenState extends State<VideoRecodingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _laterPermission = false;
  bool _isSelfieMode = false;
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    upperBound: 1.0,
    lowerBound: 0.0,
  );
  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );
    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording(); //ios만을 위한 기능

    _flashMode = _cameraController.value.flashMode;
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    _cameraController.dispose();
    if (state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) //카메라와 마이크 권한이 활성화 됐으면
    {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else if ((cameraDenied && !micDenied) ||
        (!cameraDenied && micDenied) ||
        (cameraDenied && micDenied)) {
      _laterPermission = true;
    } //권한이 하나라도 활성화 안돼있으면
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
      setState(() {
        _hasPermission = true;
      });
    }

    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    }); //애니메이션이 다 끝났을 때
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording(); //녹화 시작
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );

    // await _cameraController.takePicture(); 카메라 사진 촬영 기능
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();

    super.dispose();
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? _laterPermission
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "권한이 허용되지 않았습니다",
                        style: TextStyle(
                            fontSize: Sizes.size40, color: Colors.white),
                      ),
                    ],
                  )
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "메롱",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size72,
                        ),
                      ),
                      Gaps.v20,
                      CircularProgressIndicator.adaptive(),
                    ],
                  )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: _toggleSelfieMode,
                            color: Colors.white,
                            icon: const Icon(Icons.cameraswitch),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.off),
                            color: _flashMode == FlashMode.off
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flash_off_rounded),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.always),
                            color: _flashMode == FlashMode.always
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flash_on_rounded),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.auto),
                            color: _flashMode == FlashMode.auto
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flash_auto_rounded),
                          ),
                          Gaps.v10,
                          IconButton(
                            onPressed: () => _setFlashMode(FlashMode.torch),
                            color: _flashMode == FlashMode.torch
                                ? Colors.amber.shade200
                                : Colors.white,
                            icon: const Icon(Icons.flashlight_on_rounded),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(FontAwesomeIcons.image),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
