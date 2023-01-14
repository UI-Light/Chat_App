import 'package:chat_app2/views/shared/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final String chatRoomId;
  const Messages({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(chatRoomId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          );
        }

        if (snapshot.hasData) {
          final messages = List<Map<String, dynamic>>.from(
              (snapshot.data as QuerySnapshot).docs.map(
                    (e) => e.data(),
                  ));
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) => MessageBubble(
              message: messages[index]['text'],
              isSenderMe: messages[index]['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
            ),
          );
        }

        return const Text("Error occured");
      },
    );
  }
}
