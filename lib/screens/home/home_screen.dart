import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isy_shop/services/user_auth/auth_services.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = AuthServices();

  @override
  void initState() {
    super.initState();
    log(_auth.currentUser!.email!);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Placeholder());
  }
}
