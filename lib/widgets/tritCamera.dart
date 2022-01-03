import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../model/filters.dart';

class TritCamera extends StatefulWidget {
  @override
  TritCameraState createState() => TritCameraState();
}

class TritCameraState extends State<TritCamera> with WidgetsBindingObserver {
  List<CameraDescription> _cameras;
  CameraController _controller;
  Future<void> initController;
  var isCameraReady = false;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _setupCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      initController = _controller != null ? _controller.initialize() : null;
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });
  }

  Widget cameraWidget(context) {
    var camera = _controller.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Transform.scale(scale: scale, child: CameraPreview(_controller));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Тританопия камер',
          style: TextStyle(fontSize: 20, color: const Color(0xffFFFFFF)),
        ),
        backgroundColor: const Color(0xff4644FF), // status bar color
        brightness: Brightness.light,
      ),
      body: FutureBuilder(
        future: initController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: [
              ColorFiltered(
                  child: cameraWidget(context),
                  colorFilter: ColorFilter.matrix(TRIT_MATRIX)),
              SizedBox(
                child: cameraWidget(context),
                width: 120,
                height: 150,
              )
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> _setupCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    initController = _controller.initialize();
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });
  }

  selectCamera() async {
    var controller =
        CameraController(_cameras[_selected], ResolutionPreset.low);
    await controller.initialize();
    return controller;
  }

  toggleCamera() async {
    int newSelected = (_selected + 1) % _cameras.length;
    _selected = newSelected;
    var controller = await selectCamera();
    setState(() => _controller = controller);
  }
}
