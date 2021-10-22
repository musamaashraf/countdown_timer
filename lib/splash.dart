import 'package:countdown_timer/routes/routenames.dart';
import 'package:countdown_timer/style/common.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CommonStyles commonStyles = CommonStyles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: const Placeholder()),
            SizedBox(
              width: MediaQuery.of(context).size.height * 0.06,
            ),
            const Text('Splash Screen'),
            SizedBox(
              width: MediaQuery.of(context).size.height * 0.06,
            ),
            commonStyles.customButton(
                context: context,
                onTap: () {
                  Navigator.pushNamed(context, homeRoute);
                },
                text: 'Home')
          ],
        ),
      )),
    );
  }
}
