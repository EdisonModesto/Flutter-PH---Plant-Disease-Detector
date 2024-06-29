import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final gemini = Gemini.instance;

  Future<String> postRequest(File file) async {
    String response = "";
    await gemini.textAndImage(
        text:
            "You're detecting fruits and veggies diseases. What is in the picture and what disease it has? Your response must start with the following format: The identified \$fruit/veggie is a \$name. Then the result, include the cause, treatment and prevention is seperate paragprahps.  If no disease detected, just say its healthy. If the object cant be identified as a fruit or veggie, say that it cannot be recognized and don't say what it actually is",
        images: [file.readAsBytesSync()]).then((value) {
      response = value!.content!.parts!.last.text!;
      EasyLoading.showSuccess('Scan Completed');
    }).catchError((e) {
      EasyLoading.showError('Something went wrong');
    });

    return response;
  }
}
