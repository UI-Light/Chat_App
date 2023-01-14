import 'package:chat_app2/services/auth_service.dart';
import 'package:chat_app2/views/shared/user_tile.dart';
import 'package:chat_app2/views/ui/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL!),
                  radius: 60.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.displayName!,
                style: GoogleFonts.notoSerif(
                  fontSize: 18.0,
                ),
              ),
              Text(
                user.email!,
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.deepPurple,
              ),
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Edit Profile"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text("Invite friends"),
                ),
              ),
              GestureDetector(
                onTap: () => AuthenticationService().logOut(),
                child: const ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Sign out"),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Text(
            'ChatApp',
            style: GoogleFonts.abel(
              fontSize: 35,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemBuilder: (context, index) => UserTile(), itemCount: 10),
        // body: StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection("Chats/H3eiqdJDjvGYDWCirmB9/Messages")
        //         .snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       return ListView.builder(
        //         itemBuilder: (context, index) => UserTile(),
        //         itemCount: 10
        //       );
        //     }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const ChatScreen())));
          },
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}
