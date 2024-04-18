import 'package:flutter/cupertino.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(text),
    );
  }
}
