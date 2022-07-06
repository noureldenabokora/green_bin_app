import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/buy_old/electronic_screen.dart';
import 'package:green_bin/screens/buy_old/metal_screen.dart';
import 'package:green_bin/screens/buy_old/paper_screen.dart';
import 'package:green_bin/screens/home_screen.dart';

class BuyOldScreen extends StatelessWidget {
  const BuyOldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Buy Old',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(110.0),
              child: Container(
                height: 115,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50,
                            color: deafaultColor!.withOpacity(0.3),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svg/coins.svg'),
                              const SizedBox(width: 10),
                              Text(
                                '200',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                      color: deafaultColor,
                                    ),
                              ),
                              Text(
                                ' minimum points =  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                      wordSpacing: 1,
                                      letterSpacing: 1.1,
                                    ),
                              ),
                              Text(
                                '5 EGP',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 15,
                                      color: deafaultColor,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (() {
                                cubit.selectPaper();
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      cubit.paper ? deafaultColor : ShadeColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/paper.svg',
                                        color: cubit.paper
                                            ? Colors.white
                                            : const Color(0xff686874),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Paper',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 10,
                                              color: cubit.paper
                                                  ? Colors.white
                                                  : const Color(0xff686874),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                cubit.selectMetals();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      cubit.metals ? deafaultColor : ShadeColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/metals.svg',
                                        color: cubit.metals
                                            ? Colors.white
                                            : const Color(0xff686874),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Metals',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 10,
                                              color: cubit.metals
                                                  ? Colors.white
                                                  : const Color(0xff686874),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                cubit.selectElec();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      cubit.elec ? deafaultColor : ShadeColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/screen.svg',
                                        color: cubit.metals
                                            ? Colors.white
                                            : const Color(0xff686874),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Electronics',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                fontSize: 10,
                                                color: cubit.elec
                                                    ? Colors.white
                                                    : const Color(0xff686874)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Builder(builder: (context) {
            if (state is AppInitailbottomtabBarBuyOldSucsessState) {
              return const Paper();
            }

            if (state is ChangeBottomTabBarBuyOldState) {
              if (state.elec == true) {
                return const Electronics();
              } else if (state.metal == true) {
                return Metal();
              } else if (state.paper == true) {
                return const Paper();
              }
            }
            return const Paper();
          }),
        );
      },
    );
  }
}
