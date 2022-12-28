//import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app2/views/shared/user_tile.dart';
import 'package:chat_app2/views/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/saitama.jpg'),
                  radius: 60.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Acemma',
                style: GoogleFonts.notoSerif(
                  fontSize: 18.0,
                ),
              ),
              const Text(
                'Acemma@gmail.com',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
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
                //  onTap: () => AuthenticationService().signOut(),
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
        body: ListView(
          children: const [
            UserTile(),
            UserTile(),
            UserTile(),
            UserTile(),
            UserTile(),
            UserTile(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const ChatView())));
          },
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}

// Column(
//           children: [
//             const Center(child: Text('ChatApp HomePage')),
//             TextButton(
//                 onPressed: () {
//                   
//                 },
//                 child: const Text('Signout')),
//           ],
//         ),
