import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/buy_old/buy_old_data_screen.dart';
import 'package:green_bin/screens/buy_old/buy_old_screen.dart';
import 'package:green_bin/screens/done_order_screen.dart';
import 'package:page_transition/page_transition.dart';

class BuyOldCheckOrder extends StatelessWidget {
  const BuyOldCheckOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostBuyOldSucsessState) {
          Fluttertoast.showToast(
              msg: "Data saved successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: deafaultColor,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).push(
            PageTransition(
              child: const DoneOrderSCreen(),
              type: PageTransitionType.fade,
              alignment: Alignment.center,
              duration: const Duration(
                milliseconds: 800,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
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
                  builder: (context) => const BuyOldDataScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Order  ',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 19,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const BuyOldDataScreen(),
                          // ));
                          Navigator.of(context).push(
                            PageTransition(
                              child: BuyOldDataScreen(),
                              type: PageTransitionType.fade,
                              alignment: Alignment.center,
                              duration: const Duration(
                                milliseconds: 800,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.mode_edit_outline_outlined,
                          size: 26,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Card(
                        elevation: 4,
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/company.svg',
                                  height: 25,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '/x',
                                  // '${cubit.datebuyOld}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: constraints.maxHeight * 0.01),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/location.svg',
                                  height: 25,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'dswd',
                                  //     '${cubit.locationnnbuyOld}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/clock.svg',
                                  height: 25,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'ds',
                                  //  '${cubit.arrivaltimebuyOld}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Order',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 19,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const BuyOldScreen(),
                          // ));
                          Navigator.of(context).push(
                            PageTransition(
                              child: BuyOldScreen(),
                              type: PageTransitionType.fade,
                              alignment: Alignment.center,
                              duration: const Duration(
                                milliseconds: 800,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.mode_edit_outline_outlined,
                          size: 26,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Card(
                        elevation: 4,
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Metals',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                        letterSpacing: 1.2,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '${cubit.numberofPaperKillos}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'Plastic',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                        letterSpacing: 1.2,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '0 Kg ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'Papers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                        letterSpacing: 1.2,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '0 Kg',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 2,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 19,
                                        letterSpacing: 1.2,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '150 EGP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 18,
                                        color: deafaultColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ConditionalBuilderRec(
                    condition: true,
                    builder: (context) => deafaultButton(
                      buttonColor: deafaultColor!,
                      buttonText: 'Send Request',
                      context: context,
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const DoneOrderSCreen(),
                            type: PageTransitionType.fade,
                            alignment: Alignment.center,
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                          ),
                        );
                      },
                    ),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
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
