import 'package:go_router/go_router.dart';
import 'package:plant_disease_detector/view/home/home_view.dart';
import 'package:plant_disease_detector/widgets/camera_view.dart';

final routerConfig = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomeView(),
  ),
  GoRoute(
    path: "/camera",
    builder: (context, state) => const CameraView(),
  ),
]);
