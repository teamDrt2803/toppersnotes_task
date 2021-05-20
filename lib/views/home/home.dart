import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:toppersnotes_task/controllers/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toppersnotes_task/modals/datamodal.dart';
import 'package:toppersnotes_task/utilities/constants.dart';

import '../../main.dart';
import '../../utilities/delayedanimation.dart';
import '../../utilities/size_config.dart';
import 'components/filterbtn.dart';
import 'components/newswidget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  ///
  SwiperController _controller = SwiperController();
  late AnimationController _animationController;
  DataController _dataController = Get.find();
  late Animation<Offset> _appBaranimOffset, _bottomOffset;
  bool showing = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animationController);
    _appBaranimOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);
    _bottomOffset =
        Tween<Offset>(begin: const Offset(0.0, -0.35), end: Offset.zero)
            .animate(curve);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Obx(
        () => Scaffold(
          backgroundColor: _dataController.darkTheme.value
              ? darkTheme[BOTTOMBACKGROUND]
              : lightTheme[BOTTOMBACKGROUND],
          body: Stack(
            children: [
              _buildSwiper(),
              _buildCustAppBar(),
              _buildBottomLayout(),
              _buildDarkModeSwitch()
            ],
          ),
        ),
      ),
    );
  }

  Obx _buildDarkModeSwitch() {
    return Obx(
      () => Positioned(
        top: 30.0,
        right: 20.0,
        child: IconButton(
          onPressed: () {
            _dataController.darkTheme.value = !_dataController.darkTheme.value;
          },
          icon: _dataController.darkTheme.value
              ? Icon(
                  Icons.brightness_high,
                  color: darkTheme[TEXTCOLOR],
                )
              : Icon(
                  Icons.brightness_2,
                  color: lightTheme[TEXTCOLOR],
                ),
        ),
      ),
    );
  }

  _buildBottomLayout() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: DelayedAnimation(
        animationOffset: _appBaranimOffset,
        controller: _animationController,
        child: Obx(
          () => Visibility(
            visible: showing,
            child: Container(
              height: SizeConfig.screenHeight * 0.25,
              decoration: BoxDecoration(
                color: _dataController.darkTheme.value
                    ? darkTheme[BOTTOMBACKGROUND]
                    : lightTheme[BOTTOMBACKGROUND],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 260,
                      decoration: BoxDecoration(
                          color: _dataController.darkTheme.value
                              ? darkTheme[EXTRA]
                              : lightTheme[EXTRA],
                          borderRadius: BorderRadius.circular(99)),
                      child: Center(
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FilterButton(
                                onTap: () {
                                  _dataController.selectedIndex.value = 1;
                                },
                                isDarkTheme: _dataController.darkTheme.value,
                                selected:
                                    _dataController.selectedIndex.value != 1,
                                bgColor: _dataController.darkTheme.value
                                    ? darkTheme[SEONDARY]!
                                    : lightTheme[SEONDARY]!,
                                shadowColor: _dataController.darkTheme.value
                                    ? Colors.transparent
                                    : lightTheme[SEONDARY]!,
                                textColor: _dataController.darkTheme.value
                                    ? darkTheme[TEXTCOLOR]!
                                    : lightTheme[TEXTCOLOR]!,
                              ),
                              FilterButton(
                                onTap: () {
                                  _dataController.selectedIndex.value = 2;
                                },
                                isDarkTheme: _dataController.darkTheme.value,
                                selected:
                                    _dataController.selectedIndex.value != 2,
                                bgColor: _dataController.darkTheme.value
                                    ? darkTheme[SEONDARY]!
                                    : lightTheme[SEONDARY]!,
                                shadowColor: _dataController.darkTheme.value
                                    ? Colors.transparent
                                    : lightTheme[SEONDARY]!,
                                textColor: kPrimaryColor,
                              ),
                              FilterButton(
                                onTap: () {
                                  _dataController.selectedIndex.value = 3;
                                },
                                isDarkTheme: _dataController.darkTheme.value,
                                selected:
                                    _dataController.selectedIndex.value != 3,
                                bgColor: kPrimaryColor,
                                shadowColor: kPrimaryColor.withOpacity(0.3),
                                textColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 260,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFilterText('Unread'),
                          _buildFilterText('Read'),
                          _buildFilterText('All'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildFilterText(String text) {
    return Container(
      width: 60,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: _dataController.darkTheme.value
                ? darkTheme[TEXTCOLOR]
                : lightTheme[TEXTCOLOR],
          ),
        ),
      ),
    );
  }

  _buildSwiper() {
    return ValueListenableBuilder<Box<Result>>(
      valueListenable: newsModalBox.listenable(),
      builder: (context, box, _) {
        return Obx(() {
          var list = <Result>[];
          switch (_dataController.selectedIndex.value) {
            case 1:
              list.clear();
              list.addAll(
                  box.values.toList().where((element) => !element.read));
              break;
            case 2:
              list.clear();
              list.addAll(box.values.toList().where((element) => element.read));
              break;
            default:
              list.clear();
              list.addAll(box.values.toList());
              break;
          }
          return Swiper(
            onTap: (i) {
              if (showing) {
                _animationController.reverse();
                showing = false;
                setState(() {});
              } else {
                _animationController.forward();
                showing = true;
                setState(() {});
              }
            },
            controller: _controller,
            scrollDirection: Axis.vertical,
            itemWidth: SizeConfig.screenWidth,
            itemHeight: SizeConfig.screenHeight,
            layout: SwiperLayout.STACK,
            itemCount: list.isNotEmpty ? list.length : 1,
            itemBuilder: (context, index) {
              return list.isNotEmpty
                  ? NewsCard(
                      index: index,
                      result: list[index],
                    )
                  : Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.done,
                              size: 56,
                              color: kPrimaryColor,
                            ),
                            Text(
                              'You are all covered up',
                              style: GoogleFonts.roboto(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          );
        });
      },
    );
  }

  _buildCustAppBar() {
    return Positioned(
      top: getProportionateScreenHeight(24),
      right: 0,
      left: 0,
      child: DelayedAnimation(
        animationOffset: _bottomOffset,
        controller: _animationController,
        delay: 0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: getProportionateScreenHeight(60),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff0ccbc4),
                    ),
                    title: Text(
                      'Current Affairs',
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
