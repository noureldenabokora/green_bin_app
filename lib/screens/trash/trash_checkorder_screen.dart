import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/done_order_screen.dart';
import 'package:green_bin/screens/trash/trash_available_plans_screen.dart';
import 'package:green_bin/screens/trash/trash_screen.dart';
import 'package:page_transition/page_transition.dart';

class TrashChechOrderScreen extends StatelessWidget {
  // const TrashChechOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if (state is AppPostTrashSucsessState) {
        //   Navigator.of(context).push(
        //     PageTransition(
        //       child: const DoneOrderSCreen(),
        //       type: PageTransitionType.fade,
        //       alignment: Alignment.center,
        //       duration: const Duration(
        //         milliseconds: 800,
        //       ),
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Trash',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrashAvialablePlansScreen(
                      // time: time,
                      // garabge: garabge,
                      // place: place,
                      // reminderTime: reminderTime,
                      ),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
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
                        //   builder: (context) => const TrashScreen(),
                        // ));
                        Navigator.of(context).push(
                          PageTransition(
                            child: TrashScreen(),
                            type: PageTransitionType.fade,
                            alignment: Alignment.center,
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        IconBroken.Edit,
                        size: 26,
                        color: Color(0xff686874),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        height: 200,
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
                                'aa',
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
                              const Icon(
                                IconBroken.Location,
                                color: Color(0xff686874),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'xaa',
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
                              const Icon(
                                Icons.schedule_outlined,
                                color: Color(0xff686874),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'sdssss',
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
                                'assets/svg/reminder.svg',
                                height: 25,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'ssssssss',
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
                                'assets/svg/recycle.svg',
                                height: 25,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                ';s',
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
                      'Plan',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 19,
                          ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const TrashAvialablePlansScreen(),
                        // ));
                        Navigator.of(context).push(
                          PageTransition(
                            child: TrashAvialablePlansScreen(),
                            type: PageTransitionType.fade,
                            alignment: Alignment.center,
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        IconBroken.Edit,
                        size: 26,
                        color: Color(0xff686874),

                        // color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                buildCheckOrderItem(
                  title: 'special',
                  moneyForMonth: '20 EGP/',
                  time: '4 Month',
                  context: context,
                  selecetd: true,
                ),
                const Spacer(),
                ConditionalBuilderRec(
                  condition: true,
                  builder: (context) => deafaultButton(
                      buttonColor: deafaultColor!,
                      buttonText: 'Next',
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => DoneOrderSCreen(),
                        // ));

                        // print(cubit.loctionTrash);
                        // print(cubit.latTrash);
                        // print(cubit.lngTrash);
                        // print(cubit.arrivalTimeTrash);
                        // print(cubit.reminderTimeTrash);
                        // print(cubit.placTrash);
                        // print(cubit.garbageTrash);
                        // print(cubit.planIdTrash);
                        // print(cubit.cardnumberTrash);
                        // print(cubit.expiredateTrash);
                        // print(cubit.cvvTrash);
                        // print(cubit.holdernameTrash);

                        // cubit.postTrash(
                        //   location: cubit.loctionTrash,
                        //   lat: cubit.latTrash,
                        //   lng: cubit.lngTrash,
                        //   time: cubit.arrivalTimeTrash,
                        //   reminderTime: cubit.reminderTimeTrash,
                        //   place: cubit.placTrash,
                        //   garabgae: cubit.garbageTrash,
                        //   planId: cubit.planIdTrash,
                        //   card_number: cubit.cardnumberTrash,
                        //   expire_date: cubit.expiredateTrash,
                        //   cvv: cubit.cvvTrash,
                        //   holder_name: cubit.holdernameTrash,
                        // );
                      },
                      context: context),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
