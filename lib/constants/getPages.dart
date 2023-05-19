import 'package:get/get.dart';
import 'package:todo_app/screens/ToDo.dart';

import '../screens/splashScreen.dart';
import 'RouteConstants.dart';

List<GetPage> getPages = [
  GetPage(name: RouteConstants.splashScreen, page: () => const CSplashScreen()),
  /*GetPage(name: RouteConstants.todo, page: () => ToDo()),*/
];