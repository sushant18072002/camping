import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:task2/FirebaseCollectionController/storage_service.dart';
import 'package:task2/Utilities/color_manager.dart';
import 'package:task2/Utilities/dimension_manager.dart';
import 'package:task2/screen/mainmenu.dart';

class CameraSnap extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final int? selectCamera;

  CameraSnap({this.cameras, this.selectCamera, Key? key}) : super(key: key);

  @override
  _CameraSnapState createState() => _CameraSnapState();
}

class _CameraSnapState extends State<CameraSnap> {
  late CameraController controller;
  StorageService storage = StorageService();
  bool flag=false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![widget.selectCamera!],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: DimensionManager.divH(658),
                  width: double.infinity,
                  child: CameraPreview(controller),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/images/flash-off.png"),
                    width: 32,
                    height: 32,
                  ),
                  Container(
                      height: 64,
                      width: 64,
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(width: 2, color: ColorManager.white)),
                      child: GestureDetector(
                          onTap: (){
                            setState(() {
                              flag=true;
                            });
                            uploadImage();
                          },
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(28)),
                          ))),
                  GestureDetector(
                    onTap: () async {
                      await availableCameras().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraSnap(
                              cameras: value,
                              selectCamera:
                                  ((widget.selectCamera! + 1) % value.length),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Image(
                      image: AssetImage("assets/images/Sync.png"),
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
        Visibility(
          visible: flag,
          child: Container(
            height: DimensionManager.height,
            width: DimensionManager.width,
            alignment: Alignment.center,
            color: ColorManager.colorcccccc,
            child: const SizedBox(
              height: 100,
                width: 100,
                child: CircularProgressIndicator()),
          ),
        )
      ],
    );
  }
  uploadImage()async {
    final pictureFile = await controller.takePicture();
    //print()
    if (!mounted) return;
    print(pictureFile.path);
    print(
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    await storage
        .uploadFiles(pictureFile.path, pictureFile.name)
        .then((value) => print("Done"));
    //Navigator.pop(MyApp.navigatorKey.currentContext!);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(),));
  }
}

/**
    class DisplayPictureScreen extends StatelessWidget {
    final String imagePath;

    const DisplayPictureScreen({super.key, required this.imagePath});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Display the Picture')),
    // The image is stored as a file on the device. Use the `Image.file`
    // constructor with the given path to display the image.
    body: Image.file(File(imagePath)),
    );
    }
    }
 */
