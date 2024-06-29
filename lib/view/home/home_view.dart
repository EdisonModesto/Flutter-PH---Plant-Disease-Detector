import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plant_disease_detector/services/vision_service.dart';
import 'package:plant_disease_detector/view/results/result_sheet.dart';

import '../../utils/file_picker.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.eco_outlined,
                          size: 60,
                          color: Colors.white,
                        )),
                    const SizedBox(height: 20.0),
                    Text(
                      "Plant Disease Detector",
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: Center(
                          child: InkWell(
                            onTap: () async {
                              context.push('/camera');
                            },
                            child: Container(
                              height: 115.0,
                              width: 115.0,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.camera_outlined,
                                    color: Colors.white,
                                    size: 38,
                                  ),
                                  Text(
                                    "Take Photo",
                                    style: GoogleFonts.akayaTelivigala(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: Center(
                          child: InkWell(
                            onTap: () async {
                              File? image = await FilePickerUtil().pickImage();
                              if (image != null) {
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
                              }
                            },
                            child: Container(
                              height: 115.0,
                              width: 115.0,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(
                                    Icons.photo_outlined,
                                    size: 38,
                                  ),
                                  Text(
                                    "Scan Photo",
                                    style: GoogleFonts.akayaTelivigala(fontSize: 16.0, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
