import 'package:flutter/material.dart';
import 'package:gulstan_admin/models/UserModel.dart';
import 'package:gulstan_admin/screens/components/app_logo.dart';

class Avatar extends StatelessWidget {
  Avatar(
    this.user,
  );
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl == '') {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          radius: 70.0,
          child: ClipOval(
            child: Image.network(
              user.photoUrl,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}