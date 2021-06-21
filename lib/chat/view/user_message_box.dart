import 'package:flutter/cupertino.dart';

class UserMessageBox extends StatelessWidget {
  const UserMessageBox({
    Key? key,
    required String text,
  }) : _text = text, super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(_text)),
      padding: EdgeInsets.symmetric(vertical: 8),
    );
  }
}
