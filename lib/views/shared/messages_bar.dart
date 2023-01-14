import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagesBar extends StatefulWidget {
  final String chatRoomId;
  const MessagesBar({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  State<MessagesBar> createState() => _MessagesBarState();
}

class _MessagesBarState extends State<MessagesBar> {
  TextEditingController messageController = TextEditingController();
  var enteredMessage = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance.collection(widget.chatRoomId).add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: TextField(
          controller: messageController,
          onChanged: (value) {
            setState(() {
              enteredMessage = value;
            });
          },
          decoration: InputDecoration(
            suffixIcon: enteredMessage.trim().isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send),
                    color: Colors.deepPurple,
                  ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
