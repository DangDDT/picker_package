import 'dart:convert';

import 'package:flutter/material.dart';

class ExpansionText extends StatefulWidget {
  const ExpansionText(
    this.text, {
    super.key,
    this.collapsedLength = 200,
    this.collapsedMaxLines = 4,
    this.style,
  });
  final String text;
  final TextStyle? style;
  final int collapsedLength;
  final int collapsedMaxLines;

  @override
  State<ExpansionText> createState() => _ExpansionTextState();
}

class _ExpansionTextState extends State<ExpansionText> {
  late final String collapsedText;
  bool isCollapsed = true;
  TextPainter? textPainter;
  late bool isExpandable;

  @override
  void initState() {
    checkCollapsed();
    super.initState();
  }

  void checkCollapsed() {
    if (widget.text.length > widget.collapsedLength) {
      isExpandable = true;
      collapsedText = widget.text.substring(0, widget.collapsedLength);
    } else {
      final lines = const LineSplitter().convert(widget.text);
      if (lines.length >= widget.collapsedMaxLines) {
        isExpandable = true;
        collapsedText = lines.take(widget.collapsedMaxLines).join('\n');
      } else {
        isExpandable = false;
        collapsedText = widget.text;
      }
    }
    isCollapsed = collapsedText.length > widget.text.length;
    setState(() {});
  }

  void onTextTap() {
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 310);
    final textStyle = DefaultTextStyle.of(context).style;
    if (!isExpandable) {
      return SelectableText(
        widget.text,
        style: widget.style ?? textStyle,
        toolbarOptions: const ToolbarOptions(copy: true),
      );
    }
    return AnimatedCrossFade(
      alignment: Alignment.topLeft,
      duration: duration,
      sizeCurve: Curves.decelerate,
      firstChild: GestureDetector(
        onTap: onTextTap,
        child: SizedBox(
          child: Align(
            key: UniqueKey(),
            alignment: Alignment.centerLeft,
            child: SelectableText.rich(
              textAlign: TextAlign.start,
              TextSpan(children: [
                TextSpan(
                  text: widget.text,
                  style: widget.style ?? DefaultTextStyle.of(context).style,
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: onTextTap,
                    child: Text(
                      ' Thu gọn',
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                  style: textStyle,
                )
              ]),
            ),
          ),
        ),
      ),
      secondChild: Align(
        key: UniqueKey(),
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onTextTap,
          child: SelectableText.rich(
            textAlign: TextAlign.start,
            TextSpan(
              children: [
                TextSpan(
                  text: '$collapsedText... ',
                  style: widget.style ?? textStyle,
                ),
                WidgetSpan(
                  child: InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      onTap: onTextTap,
                      child: Text(
                        "Xem thêm",
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).disabledColor,
                        ),
                      )),
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      ),
      crossFadeState: isCollapsed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
