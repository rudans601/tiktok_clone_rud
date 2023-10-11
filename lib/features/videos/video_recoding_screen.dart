import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class VideoRecodingScreen extends StatefulWidget {
  const VideoRecodingScreen({super.key});

  @override
  State<VideoRecodingScreen> createState() => _VideoRecodingScreenState();
}

class _VideoRecodingScreenState extends State<VideoRecodingScreen> {
  bool _hasPermission = false;
  bool _laterPermission = false;
  bool _isSelfieMode = false;
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
    _flashMode = _cameraController.value.flashMode;
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
    } //권한이 하나라도 활성화
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPermissions();
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: (!_hasPermission || !_cameraController.value.isInitialized)
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
                  CameraPreview(_cameraController),
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
                          color: _flashMode == FlashMode.auto
                              ? Colors.amber.shade200
                              : Colors.white,
                          icon: const Icon(Icons.flashlight_on_rounded),
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
