import 'package:flutter/material.dart';

class CommonPopUpFilter<E> extends StatelessWidget {
  final String? name;
  final E? currentSelection;
  final Map<E, String> mapSelection;
  final Function()? onPressed;
  final String hintText;
  final bool allowClean;
  final VoidCallback? onClean;
  const CommonPopUpFilter({
    super.key,
    this.onPressed,
    required this.currentSelection,
    required this.mapSelection,
    this.hintText = "Chọn",
    this.name,
    this.allowClean = false,
    this.onClean,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: theme.disabledColor.withOpacity(.05),
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        child: ListTile(
          title: Text(
            mapSelection[currentSelection] ?? hintText,
            style: theme.textTheme.titleSmall!.copyWith(
                color: mapSelection[currentSelection] != null
                    ? null
                    : theme.disabledColor),
          ),
          trailing: Builder(builder: (context) {
            if (allowClean) {
              return GestureDetector(
                onTap: onClean,
                child: Icon(
                  (mapSelection[currentSelection] == null)
                      ? Icons.arrow_drop_down
                      : Icons.close,
                  color: theme.textTheme.titleSmall!.color,
                ),
              );
            } else {
              return Icon(
                Icons.arrow_drop_down,
                color: theme.textTheme.titleSmall!.color,
              );
            }
          }),
        ),
      ),
    );
  }
}

class PrimaryPopUpFilter<E> extends StatelessWidget {
  final String? name;
  final E? currentSelection;
  final Map<E, String> mapSelection;
  final Function()? onPressed;
  final String hintText;
  final bool allowClean;
  final VoidCallback? onClean;
  const PrimaryPopUpFilter({
    super.key,
    this.onPressed,
    required this.currentSelection,
    required this.mapSelection,
    this.hintText = "Chọn",
    this.name,
    this.allowClean = false,
    this.onClean,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
        ),
        child: ListTile(
          dense: true,
          title: Text(
            mapSelection[currentSelection] ?? hintText,
            style: theme.textTheme.titleSmall!
                .copyWith(color: theme.colorScheme.onPrimary),
          ),
          trailing: Builder(builder: (context) {
            if (allowClean) {
              return GestureDetector(
                onTap: onClean,
                child: Icon(
                  (mapSelection[currentSelection] == null)
                      ? Icons.arrow_drop_down
                      : Icons.close,
                  color: theme.colorScheme.onPrimary,
                ),
              );
            } else {
              return Icon(
                Icons.arrow_drop_down,
                color: theme.textTheme.titleSmall!.color,
              );
            }
          }),
        ),
      ),
    );
  }
}
