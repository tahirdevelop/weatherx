import 'package:flutter/material.dart';

class SplashScreenWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;

  SplashScreenWrapper({this.duration, this.child, Key key}) : super(key: key);

  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  Future<void> splash;

  @override
  void initState() {
    splash = Future.delayed(widget.duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: splash,
      builder: (context, snapshot) {
        return Stack(
          children: [
            widget.child,
            if (snapshot.connectionState == ConnectionState.waiting)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(71, 191, 223, 1),
                      Color.fromRGBO(74, 145, 255, 1),
                    ],
                  ),
                ),
                child: Image.asset('assets/images/splash-logo.png'),
              ),
          ],
        );
      },
    );
  }
}
