// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  const CustomChip({
    Key? key,
    this.icon,
    this.action,
    required this.title,
    this.color,
    this.fillColor = true,
    this.border,
    this.onTap,
    this.constraints,
    this.textStyle,
    this.padding,
  }) : super(key: key);
  final Widget? icon;
  final Widget? action;
  final String title;
  final TextStyle? textStyle;
  final Color? color;
  final bool fillColor;
  final BoxBorder? border;
  final Function()? onTap;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isPressed = false;
  bool isLoading = false;

  void _togglePressed(bool value) {
    setState(() {
      isPressed = value;
    });
  }

  void _onTap() async {
    setState(() {
      isLoading = true;
    });
    await widget.onTap?.call();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foregroundColor = widget.color ?? theme.colorScheme.primary;
    final backgroundColor = foregroundColor.withOpacity(.2);
    final padding = widget.padding ??
        EdgeInsets.symmetric(
          vertical: 6,
          horizontal: (widget.icon != null || widget.action != null) ? 8 : 12,
        );
    final child = AnimatedContainer(
      constraints: widget.constraints,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.fillColor ? backgroundColor : null,
        border: widget.border,
      ),
      duration: const Duration(milliseconds: 410),
      child: IconTheme(
        data: IconThemeData(
          color: foregroundColor,
          size: theme.textTheme.bodySmall?.height ?? 14,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) widget.icon!,
            if (widget.icon != null) const SizedBox(width: 4),
            Flexible(
              child: DefaultTextStyle(
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w500,
                ),
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.textStyle,
                ),
              ),
            ),
            if (widget.action != null) const SizedBox(width: 4),
            if (widget.action != null) widget.action!,
          ],
        ),
      ),
    );
    return (widget.onTap != null) ? _opTapWrapper(child: child) : child;
  }

  Widget _opTapWrapper({required Widget child}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: isPressed ? .5 : 1,
      child: GestureDetector(
        onTap: widget.onTap != null ? (isLoading ? null : _onTap) : null,
        onTapDown: widget.onTap != null ? (_) => _togglePressed(true) : null,
        onTapUp: widget.onTap != null ? (_) => _togglePressed(false) : null,
        onPanEnd: widget.onTap != null ? (_) => _togglePressed(false) : null,
        onTapCancel: widget.onTap != null ? () => _togglePressed(false) : null,
        child: child,
      ),
    );
  }
}
