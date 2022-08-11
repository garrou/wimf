import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wimf/styles/style.dart';
import 'package:wimf/views/auth/login.dart';
import 'package:wimf/views/home/discover.dart';
import 'package:wimf/widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/snowman.svg',
                semanticsLabel: 'Logo',
                height: 300,
              ),
              Padding(
                child: Text("What's In My Freezer ?", style: titleTextStyle),
                padding: const EdgeInsets.all(20),
              ),
              AppButton(
                content: 'Découvrir',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const DiscoverPage(),
                  ),
                ),
              ),
              AppButton(
                content: 'Se connecter',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
