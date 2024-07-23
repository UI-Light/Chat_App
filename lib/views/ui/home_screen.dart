import 'package:chat_app2/models/user.dart';
import 'package:chat_app2/services/auth_service.dart';
import 'package:chat_app2/views/shared/user_tile.dart';
import 'package:chat_app2/views/ui/chat_screen.dart';
import 'package:chat_app2/views/ui/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = AuthenticationService.currentUser!;

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
 child: user.photoURL == null
              ? Text(user.displayName.substring(0, 2).toUpperCase())
              : null,                  
              radius: 60.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.displayName,
                style: GoogleFonts.notoSerif(
                  fontSize: 18.0,
                ),
              ),
              Text(
                user.email,
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
                onTap: () async {
                  await AuthenticationService.logOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return const LoginScreen();
                      }),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Sign out"),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
  
        // backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 1.0,
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
        // body: ListView.builder(
        //     itemBuilder: (context, index) => UserTile(), itemCount: 10),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                final users = List<AppUser>.from(
                    (snapshot.data as QuerySnapshot).docs.map((e) {
                  return AppUser.fromJson(e.data() as Map<String, dynamic>);
                }));
                return ListView.builder(
                  itemBuilder: (context, index) => UserTile(
                    user: users[index],
                  ),
                  itemCount: users.length,
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
