import 'package:chat_app2/models/user.dart';
import 'package:chat_app2/services/auth_service.dart';
import 'package:chat_app2/views/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  final AppUser user;

  const UserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentUser = AuthenticationService.currentUser;
        final users = [currentUser!.displayName, user.displayName];
        users.sort((a, b) => a.compareTo(b));
        final chatRoomId = users.join("-");

        Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => ChatScreen(
                chatRoomId: chatRoomId,
                user: user,
              )),
        ));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              user.photoURL == null ? null : NetworkImage(user.photoURL!),
          child: user.photoURL == null
              ? Text(user.displayName.substring(0, 2).toUpperCase())
              : null,
        ),
        title: Text(
          user.displayName,
          style: GoogleFonts.roboto(
            fontSize: 18,
          ),
        ),
        subtitle: const Text(
          'Hey human i didn\'t see you in school today lorem ipsum blah blah',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Text('12:30pm'),
      ),
    );
  }
}
