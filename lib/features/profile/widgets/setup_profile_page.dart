import 'dart:async';
import 'package:flutter/material.dart';


import '../../../core/components/splash_page.dart';
import 'profile_form_page.dart';


class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({super.key});

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startTransitionTimers();
  }

  void _startTransitionTimers() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _currentPage = 1;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          _currentPage = 2;
        });
        Timer(const Duration(seconds: 7), () {
          setState(() {
            _currentPage = 3;
          });
          Timer(const Duration(seconds: 2), () {
            setState(() {
              _currentPage = 4;
            });
          });
        });
      });
    });
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget _getCurrentWidget() {
    switch (_currentPage) {
      case 0:
        return const SplashPage(key: ValueKey(10));
      case 1:
        return const SizedBox(key: ValueKey(11));
      case 2:
        return const WelcomeWidget(key: ValueKey(12));
      case 3:
        return const SizedBox(key: ValueKey(13));
      case 4:
        return ProfileFormBuilder(key: const ValueKey(14));
      default:
        return const SplashPage(key: ValueKey(10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          if (_currentPage == 0) {
            // Only fade out when transitioning from SplashPage
            return FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
              child: child,
            );
          } else {
            // Fade in and out for other transitions
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }
        },
        child: _getCurrentWidget(),
      ),
    );
  }
}


class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  bool _showSecondText = false;

  @override
  void initState() {
    super.initState();
    // Start a delayed timer to show the second text after 2 seconds (for example)
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showSecondText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to Modawan', style: TextStyle(fontSize: 26)),
          const SizedBox(height: 20), // Adding some space between the texts
          AnimatedOpacity(
            opacity: _showSecondText ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500), // Animation duration
            curve: Curves.easeInOut, // Optional: easing curve
            child: const Text(
              'Let\'s setup your profile',
              style: TextStyle(fontSize: 18), // Optional: adjust text style
            ),
          ),
        ],
      ),
    );
  }
}
