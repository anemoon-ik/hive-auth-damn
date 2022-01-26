import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/auth.dart';
import 'package:hive_demo/model/transaction.dart';
import 'package:hive_demo/screens/login.dart';
import 'package:hive_demo/wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_demo/page/transaction_page.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBRHcb5wAmAvmW4P9JAMwxTgzKhZQ8Zjlg",
          appId: "egeaiyl",
          messagingSenderId: "429446794223",
          projectId: "1:429446794223:web:57dc2c21fff9162df3841a"));

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Считаем твои расходы вместе';

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [Provider<AuthService>(create: (_) => AuthService())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(primarySwatch: Colors.lightGreen),
          home: const Wrapper(),
        ),
      );
}
