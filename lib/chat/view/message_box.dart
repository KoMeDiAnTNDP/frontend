import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key? key,
    required String text,
    required bool isOwn,
    required DateTime dateTime,
    required String email,
  }) : _text = text, _isOwn = isOwn, _dateTime = dateTime, _email = email, super(key: key);

  final String _text;
  final bool _isOwn;
  final DateTime _dateTime;
  final String _email;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isOwn ? Colors.white : Theme.of(context).primaryColor;
    final align = _isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = _isOwn ? BorderRadius.only(
      topLeft: Radius.circular(5),
      bottomRight: Radius.circular(10),
      bottomLeft: Radius.circular(5),
    ) : BorderRadius.only(
      topRight: Radius.circular(5),
      bottomRight: Radius.circular(5),
      bottomLeft: Radius.circular(10),
    );
    final dateFormat = DateFormat.jm();
    final date = dateFormat.format(_dateTime);

    return Column(
      crossAxisAlignment: align,
      children: [
        _isOwn ? Container() : Text(_email),
        Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                blurRadius: .5,
                spreadRadius: 1,
                color: Colors.black.withOpacity(.12),
              )
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 48),
                child: Text(_text),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  date,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 10
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
