import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            'Quản Lý Công Việc',
            style: theme.textTheme.titleMedium,
          ),
        ),
        const Flexible(child: _SearchField()),
      ],
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final _focusNode = FocusNode();
  late final TextEditingController textEditingController;
  bool isShowSearchField = false;

  void _toggleSearchField() => setState(() {
        if (textEditingController.text.isNotEmpty) {
          return;
        }
        isShowSearchField = !isShowSearchField;
        if (isShowSearchField) {
          _focusNode.requestFocus();
        }
      });

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _toggleSearchField();
    }
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    _focusNode.addListener(() => _onFocusChange());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSearchField,
      child: Container(
        height: 40,
        constraints: const BoxConstraints(minWidth: 40),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedSize(
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 250),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                if (isShowSearchField)
                  Expanded(
                    child: TextFormField(
                      focusNode: _focusNode,
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm kiếm công việc',
                      ),
                    ),
                  ),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
