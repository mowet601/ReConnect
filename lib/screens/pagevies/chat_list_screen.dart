import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:naya_project/Widgets/main_appbar.dart';
import 'package:naya_project/models/contacts.dart';
import 'package:naya_project/provider/user_provider.dart';

import 'package:naya_project/resources/chat_methods.dart';
import 'package:naya_project/screens/call_screens/pickup/pickup_layout.dart';
import 'package:naya_project/screens/pagevies/Widgets/chat_button.dart';
import 'package:naya_project/utils/universal_utilities.dart';

import 'package:provider/provider.dart';

import 'Widgets/contact_vie.dart';
import 'Widgets/quietbox.dart';
import 'Widgets/user_circle.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        appBar: MainAppBar(
          title: UserCircle(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: NewChatButton(),
        body: ChatListContainer(),
      ),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(
            userId: userProvider.getUser.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;

              if (docList.isEmpty) {
                return QuietBox(
                  heading: "This is where all the contacts are listed",
                  subtitle:
                      "Search for your friends and family to start calling or chatting with them",
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);

                  return ContactView(contact);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
