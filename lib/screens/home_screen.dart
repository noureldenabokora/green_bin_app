import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: deafaultColor,
                currentIndex: cubit.currentIndex,
                unselectedItemColor: Colors.grey,
                onTap: (value) {
                  cubit.changeBottomNAvBAr(value);
                },
                elevation: 50,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Notification),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Buy),
                    label: 'My cart',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
