import 'package:flutter/material.dart';

class TextBar extends StatefulWidget {
  const TextBar({Key? key}) : super(key: key);

  @override
  State<TextBar> createState() => _TextBarState();
}

class _TextBarState extends State<TextBar> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.emoji_emotions,
            color: Colors.grey,
          ),
          suffixIcon: textController.text.isNotEmpty
              ? GestureDetector(
                  child: const Icon(
                    Icons.send,
                    color: Colors.deepPurple,
                  ),
                  onTap: () => textController.clear(),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
