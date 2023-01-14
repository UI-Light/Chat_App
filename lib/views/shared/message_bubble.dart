import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSenderMe;

  const MessageBubble(
      {Key? key, required this.message, required this.isSenderMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSenderMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSenderMe ? Colors.deepPurple : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: isSenderMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: isSenderMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: GoogleFonts.notoSerif(
              color: isSenderMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
