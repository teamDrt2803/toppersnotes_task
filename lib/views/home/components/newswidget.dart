import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toppersnotes_task/controllers/data.dart';
import 'package:toppersnotes_task/modals/datamodal.dart';

import '../../../main.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_config.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({
    Key? key,
    required this.result,
    required this.index,
  }) : super(key: key);
  final Result result;
  final int index;

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  DataController _dataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          _buildNewsThumb(),
          _buildNewsDetails(widget.index),
        ],
      ),
    );
  }

  Positioned _buildNewsDetails(int index) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Obx(
        () => Container(
          height: SizeConfig.screenHeight * 0.7,
          decoration: BoxDecoration(
            color: _dataController.darkTheme.value
                ? darkTheme[MAINBG]
                : lightTheme[MAINBG],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(5, 8),
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    var index1 = newsModalBox.values
                        .toList()
                        .indexWhere((element) => element == widget.result);
                    newsModalBox.putAt(
                      index1,
                      widget.result.copyWith(
                        read: !widget.result.read,
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: _dataController.darkTheme.value
                          ? darkTheme[SEONDARY]
                          : lightTheme[SEONDARY],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _dataController.darkTheme.value
                              ? Colors.transparent
                              : lightTheme[SEONDARY]!,
                          blurRadius: 16,
                          offset: Offset(0, 3),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done_all,
                        // color: Colors.green,
                        color: widget.result.read
                            ? darkTheme[PRIMARY]
                            : _dataController.darkTheme.value
                                ? darkTheme[TEXTCOLOR]
                                : lightTheme[TEXTCOLOR]!,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '#HASHTAG1',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          TextSpan(
                            text: '#HASHTAG2'.padLeft(10),
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    spacer(
                      getProportionateScreenHeight(19),
                      null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 65),
                      child: Text(
                        widget.result.title,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: _dataController.darkTheme.value
                              ? darkTheme[TEXTCOLOR]
                              : lightTheme[TEXTCOLOR],
                        ),
                      ),
                    ),
                    spacer(
                      getProportionateScreenHeight(19),
                      null,
                    ),
                    Text(
                      widget.result.description,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: _dataController.darkTheme.value
                            ? darkTheme[TEXTCOLOR]
                            : lightTheme[TEXTCOLOR],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildNewsThumb() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        height: SizeConfig.screenHeight * 0.35,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.result.urlToImage),
          ),
        ),
      ),
    );
  }
}
