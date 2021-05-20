import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.onTap,
    required this.selected,
    required this.isDarkTheme,
    required this.bgColor,
    required this.shadowColor,
    required this.textColor,
  }) : super(key: key);

  final Function() onTap;
  final bool selected, isDarkTheme;
  final Color bgColor, shadowColor, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: selected
              ? []
              : [
                  BoxShadow(
                    offset: Offset(2, 10),
                    color: shadowColor,
                    blurRadius: 16,
                  ),
                ],
        ),
        child: Center(
          child: Icon(
            Icons.done_all,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
