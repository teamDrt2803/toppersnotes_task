import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:toppersnotes_task/controllers/data.dart';
// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:toppersnotes_task/utilities/constants.dart';
import 'package:toppersnotes_task/modals/datamodal.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toppersnotes_task/views/home/home.dart';

late Box<Result> newsModalBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsModalAdapter());
  Hive.registerAdapter(ResultAdapter());
  newsModalBox = await Hive.openBox<Result>('news');
  runApp(MyApp());
}

NewsModal newsModal = NewsModal.fromMap(NEWSDUMMYDATA);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder.put(
        () => DataController(),
      ),
      debugShowCheckedModeBanner: false,
      title: 'TopperNotes Task',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
