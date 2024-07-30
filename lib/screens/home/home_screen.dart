import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isy_shop/screens/home/pages/home.dart';
import 'package:isy_shop/services/user_auth/auth_services.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = AuthServices();

  int _currentIndex = 0;
  final _body = [
    const Home(),
    const Icon(Icons.search),
    const Icon(Icons.bookmark_outline),
    const Icon(Icons.person_2_outlined),
  ];

  @override
  void initState() {
    super.initState();
    log(_auth.currentUser!.email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/brand/logos/isyshop-cropped.png',
              width: 100,
            ),
            const Icon(Icons.notifications_outlined)
          ],
        ),
      ),
      body: _body[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (value) => setState(() => _currentIndex = value),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  label: 'Bookmark'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
