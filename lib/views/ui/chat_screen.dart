import 'package:chat_app2/models/user.dart';
import 'package:chat_app2/views/shared/messages.dart';
import 'package:chat_app2/views/shared/messages_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final AppUser user;
  final String chatRoomId;

  const ChatScreen({
    Key? key,
    required this.user,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading:  Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: CircleAvatar(
            child: user.photoURL == null
              ? Text(user.displayName.substring(0, 2).toUpperCase())
              : null,
          ),
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                // const Text(
                //   'Last seen 12:00pm',
                //   style: TextStyle(
                //     fontSize: 11,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(chatRoomId: chatRoomId),
          ),
          MessagesBar(chatRoomId: chatRoomId),
        ],
      ),
    );
  }
}
