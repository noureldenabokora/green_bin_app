import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/screens/home_screen.dart';
import 'package:green_bin/screens/layout_screen.dart';

class DoneOrderSCreen extends StatefulWidget {
  const DoneOrderSCreen({Key? key}) : super(key: key);

  @override
  State<DoneOrderSCreen> createState() => _DoneOrderSCreenState();
}

class _DoneOrderSCreenState extends State<DoneOrderSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/doneorder.png',
                    height: 270,
                  ),
                  Text(
                    'Your order has been sent sucssecfully',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(height: 45),
                  deafaultButton(
                    buttonColor: deafaultColor!,
                    buttonText: 'Home',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                    },
                    context: context,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Continue Ordering',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
