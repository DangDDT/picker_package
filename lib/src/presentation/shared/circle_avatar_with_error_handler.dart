import 'package:core_picker/core/core.dart';
import 'package:flutter/material.dart';

class CircleAvatarWithErrorHandler extends StatefulWidget {
  const CircleAvatarWithErrorHandler({
    super.key,
    required this.avatarUrl,
    required this.fullName,
    this.baseUrl,
    this.radius = 12,
  });
  final String? baseUrl;
  final String? avatarUrl;
  final String? fullName;
  final double radius;

  @override
  State<CircleAvatarWithErrorHandler> createState() => _CircleAvatarWithErrorHandlerState();
}

class _CircleAvatarWithErrorHandlerState extends State<CircleAvatarWithErrorHandler> {
  bool isAvatarLoadError = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primary.withOpacity(.8);
    TextStyle textStyle = theme.primaryTextTheme.titleSmall!.copyWith(
      color: backgroundColor.textColor,
    );

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: backgroundColor,
      backgroundImage: widget.avatarUrl != null
          ? Image.network(
              '${widget.baseUrl ?? ''}/${widget.avatarUrl}',
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              height: widget.radius,
              width: widget.radius,
            ).image
          : null,
      onBackgroundImageError: widget.avatarUrl != null
          ? (exception, stackTrace) {
              if (!isAvatarLoadError) {
                setState(() {
                  isAvatarLoadError = true;
                });
              }
            }
          : null,
      child: (widget.avatarUrl == null || isAvatarLoadError)
          ? Center(
              child: Text(
                widget.fullName!.initialWords.toUpperCase(),
                style: textStyle.copyWith(
                  fontSize: widget.radius / 1.3,
                ),
              ),
            )
          : null,
    );
  }
}
