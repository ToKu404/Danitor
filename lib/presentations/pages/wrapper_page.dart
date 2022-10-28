import 'package:danitor/presentations/pages/login_page.dart';
import 'package:danitor/presentations/pages/main_page.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AuthNotifier>(context, listen: false)..checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, state, data) {
      if (state.authState == RequestState.success) {
        if (state.isLogin || state.isAnonymous) {
          return MainPage();
        } else {
          return LoginPage();
        }
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
