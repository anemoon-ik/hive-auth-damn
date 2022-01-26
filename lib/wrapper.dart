import 'package:flutter/material.dart';
import 'package:hive_demo/page/transaction_page.dart';
// import 'package:hive_demo/screens/home.dart';
import 'package:hive_demo/screens/login.dart';
import 'package:hive_demo/auth.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? const Login() : TransactionPage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
