import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plant_disease_detector/services/vision_service.dart';
import 'package:plant_disease_detector/view/results/result_sheet.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CameraCamera(
      onFile: (image) async {
        EasyLoading.show(
          status: "Loading...",
          indicator: const CircularProgressIndicator(),
        );
        //  String imgUrl = await CloudService().uploadImageToFirebase(image);
        final result = await GeminiService().postRequest(image);
        String content = result;
        if (mounted) {
          await showMaterialModalBottomSheet(
            context: context,
            builder: (builder) {
              return ResultSheet(result: content, image: image);
            },
          );
        }
      },
    ));
  }
}
