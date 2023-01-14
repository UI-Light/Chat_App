import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  UserTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user == null ? null : NetworkImage(user.photoURL!),
      ),
      title: Text(
        user.displayName ?? "Empty",
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
    );
  }
}
