import 'package:flutter/material.dart';
import 'package:graduation_project/constant/fontstyle.dart';

class CustomTabView extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  CustomTabView(
      {Key? key,
      required this.changeTab,
      required this.index,
      this.activeBotton,
      this.unactiveBotton,
      this.activeText,
      this.unactiveText,
      required this.tags})
      : super(key: key);
  Color? activeBotton, unactiveBotton, activeText, unactiveText;
  final List<String> tags;
  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  Widget _buildTags(int index) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          widget.changeTab(index);
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width * .5,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07,
              vertical: 10),
          decoration: BoxDecoration(
            color: widget.index == index
                ? widget.activeBotton ?? Colors.blue.shade900
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.tags[index],
            style: fonttitlestyle.fonttitle,

            // TEXT_NORMAL.copyWith(
            //     color: widget.index != index
            //         ? widget.unactiveText ?? BLACK_COLOR
            //         : widget.activeText ?? WHITH_COLOR),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8 * .7,
        ),
        width: MediaQuery.sizeOf(context).width * .9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.unactiveBotton ?? Colors.blue.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.tags
              .asMap()
              .entries
              .map((MapEntry map) => _buildTags(map.key))
              .toList(),
        ),
      ),
    );
  }
}
