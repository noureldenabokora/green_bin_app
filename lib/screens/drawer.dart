import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/login/login_screen.dart';
import 'package:green_bin/screens/person/person_screen.dart';
import 'package:green_bin/shared/cache_helper.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        var image = cubit.image;
        return Drawer(
          elevation: 0,
          child: Material(
            // color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 10,
              ),
              child: ListView(
                children: [
                  builduserItem(cubit, image),
                  buildItemDrawer(
                    icon: IconBroken.Profile,
                    title: 'Profile',
                    color: Colors.black,
                    tap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PersonScreen(),
                      ));
                    },
                  ),
                  buildItemDrawer(
                    icon: Icons.schedule_outlined,
                    //add_circle_outline_sharp
                    //remove_circle_outline_sharp,
                    title: 'Order History',
                    color: Colors.black,
                  ),
                  buildItemDrawer(
                    icon: Icons.security,
                    title: 'Safety and security ',
                    color: Colors.black,
                  ),
                  buildItemDrawer(
                    icon: Icons.contact_support_outlined,
                    title: 'Support ',
                    color: Colors.black,
                  ),
                  const Divider(),
                  buildItemDrawer(
                    icon: IconBroken.Setting,
                    title: 'Settings ',
                    color: Colors.black,
                  ),
                  buildItemDrawer(
                    icon: Icons.error_outline,
                    title: 'About Us ',
                    color: Colors.black,
                  ),
                  const Divider(),
                  buildItemDrawer(
                      icon: IconBroken.Logout,
                      title: 'Log Out ',
                      color: deafaultColor!,
                      tap: () {
                        CacheHellper.removeData(key: 'apiToken').then((value) {
                          if (value) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget builduserItem(AppCubit cubit, image) => Stack(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: deafaultColor,
            ),
          ),
          Container(
            color: Colors.white30,
            height: 80,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: image == null
                    ? NetworkImage(
                        ('${cubit.user?.data.data!.user_image}'),
                      )
                    : FileImage(image) as ImageProvider,
              ),
              title: Text(
                '${cubit.user?.data.data!.user_name}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
              ),
              subtitle: Text(
                '${cubit.user?.data.data!.user_points}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
              ),
            ),
          ),
        ],
      );

  Widget buildItemDrawer({
    required IconData icon,
    required String title,
    required Color color,
    void Function()? tap,
  }) =>
      ListTile(
        onTap: tap,
        leading: Icon(
          icon,
          color: color,
          size: 28,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 14,
              ),
        ),
      );
}
