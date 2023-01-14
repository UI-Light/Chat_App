import 'package:chat_app2/views/shared/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      //asyncSnapshot
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
            ),
          );
        } else {
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => MessageBubble(
              message: snapshot.data!.docs[index]['text'],
              isSenderMe: snapshot.data!.docs[index]['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
            ),
          );
        }
      },
    );
  }
}
