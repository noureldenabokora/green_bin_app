import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/buy_old/buy_old_screen.dart';
import 'package:green_bin/screens/cleaner/cleaner_screen.dart';
import 'package:green_bin/screens/drawer.dart';
import 'package:green_bin/screens/exchange_products/exchange_products_screen.dart';
import 'package:green_bin/screens/trash/trash_screen.dart';
import 'package:page_transition/page_transition.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var user = cubit.user?.data.data;
        var facebookUser = cubit.currentUser;

        var googelUser = cubit.googleAccount;

        return Scaffold(
          drawer: const DrawerScreen(),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
            ),
            actions: [
              Row(
                children: [
                  if (user?.user_image != null &&
                      cubit.currentUser == null &&
                      cubit.googleAccount == null)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(user?.user_image == null
                          ? 'https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1656317211~exp=1656317811~hmac=b97aff7c460cd771ad19f1f6f32e2dba8ca86fb1ca6a0b9873a115efc9731b82&w=740'
                          : '${user?.user_image}'),
                    ),
                  if (cubit.currentUser != null &&
                      cubit.googleAccount == null &&
                      user?.user_image == null)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage('${facebookUser?.pictureModel?.url}'),
                    ),
                  if (cubit.googleAccount != null &&
                      user?.user_image == null &&
                      cubit.currentUser == null)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage('${googelUser?.photoUrl}'),
                    ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user != null &&
                      cubit.currentUser == null &&
                      cubit.googleAccount == null)
                    Text(
                      'Hello ${user.user_name}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                    ),
                  if (user == null &&
                      cubit.currentUser != null &&
                      cubit.googleAccount == null)
                    Text(
                      'Hello ${facebookUser!.name}',

                      //   'Hello ${user?.user_name}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                    ),
                  if (user == null &&
                      cubit.currentUser == null &&
                      cubit.googleAccount != null)
                    Text(
                      'Hello ${googelUser!.displayName}',

                      //   'Hello ${user?.user_name}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                    ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Text(
                    'Hope you a clean life',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 19,
                          color: Colors.black,
                          wordSpacing: 3.5,
                        ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Current subscriptions',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      // const Spacer(),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('See All'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Row(
                    children: [
                      buildStaticSubscription(
                          context, 'cleaner', -20, constraints),
                      //   const Spacer(),
                      SizedBox(width: constraints.maxWidth * 0.05),

                      buildStaticSubscription(
                          context, 'Trash', -15, constraints),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.016),
                  Text(
                    'Services',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: TrashScreen(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: constraints.maxHeight * 0.25,
                                width: double.infinity,
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset('assets/svg/group.svg'),
                                  SizedBox(
                                      height: constraints.maxHeight * 0.01),
                                  Text(
                                    'Trash',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: CleanerScreen(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: constraints.maxHeight * 0.25,
                                width: double.infinity,
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset('assets/svg/cleaner.svg'),
                                  SizedBox(
                                      height: constraints.maxHeight * 0.01),
                                  Text(
                                    'Cleaner',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: const ExchangeProductsScreen(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: constraints.maxHeight * 0.25,
                                width: double.infinity,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/tools.svg'),
                                  SizedBox(
                                      height: constraints.maxHeight * 0.01),
                                  Text(
                                    'Exchage products',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageTransition(
                                child: const BuyOldScreen(),
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(
                                  milliseconds: 1000,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: constraints.maxHeight * 0.25,
                                width: double.infinity,
                              ),
                              Column(
                                children: [
                                  SvgPicture.asset('assets/svg/oldtv.svg'),
                                  SizedBox(
                                      height: constraints.maxHeight * 0.01),
                                  Text(
                                    'Old Things',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildStaticSubscription(
          context, String title, int days, BoxConstraints constraints) =>
      Expanded(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: double.infinity,
              height: constraints.maxHeight * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: deafaultColor!.withOpacity(0.2),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/subscrption.svg'),
                    SizedBox(width: constraints.maxWidth * 0.01),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$days',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 15,
                            color: deafaultColor,
                          ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.01),
                    Text(
                      'days',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14,
                            color: deafaultColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}
