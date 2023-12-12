import 'package:get/get.dart';
import 'package:todo_app/screens/ToDo.dart';
import 'package:todo_app/screens/addTodo.dart';
import 'package:todo_app/screens/detail_screen.dart';

import '../screens/splashScreen.dart';
import 'RouteConstants.dart';

List<GetPage> getPages = [
  GetPage(name: RouteConstants.splashScreen, page: () => const CSplashScreen()),
  GetPage(name: RouteConstants.addTodo, page: () => AddTodo()),
  GetPage(name: RouteConstants.detailScreen, page: () => DetailScreen()),
];