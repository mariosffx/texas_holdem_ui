import 'package:flutter/material.dart';

enum MessageType { error, result }

class Message extends StatelessWidget {
  final String? messageText;
  final String? messageType;

  const Message({
    super.key,
    required this.messageText,
    required this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: messageText != null
          ? Align(
              alignment: Alignment.topLeft,
              child: Text(
                messageText ?? "",
                style: messageType == "error"
                    ? TextStyle(color: Theme.of(context).colorScheme.error)
                    : messageType == "success"
                    ? TextStyle(color: Theme.of(context).colorScheme.primary)
                    : null,
              ),
            )
          : null,
    );
  }
}
