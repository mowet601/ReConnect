import 'package:flutter/material.dart';
import 'package:naya_project/Widgets/customtile.dart';
import 'package:naya_project/models/contacts.dart';
import 'package:naya_project/models/user.dart';
import 'package:naya_project/provider/user_provider.dart';
import 'package:naya_project/resources/auth_methods.dart';
import 'package:naya_project/resources/chat_methods.dart';
import 'package:naya_project/screens/chat_screens/chat_screen.dart';
import 'package:naya_project/screens/chat_screens/widgets/cached_image.dart';
import 'package:naya_project/screens/pagevies/Widgets/last_message.dart';
import 'package:naya_project/screens/pagevies/Widgets/online_dot_indicator.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods _authMethods = AuthMethods();

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final ChatMethods _chatMethods = ChatMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        (contact != null ? contact.name : null) != null ? contact.name : "..",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid,
            ),
          ],
        ),
      ),
    );
  }
}
