import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/location_model.dart';
import 'package:green_bin/screens/buy_old/buy_old_checkorder_screen.dart';
import 'package:green_bin/screens/buy_old/buy_old_screen.dart';
import 'package:green_bin/screens/cleaner/google.dart';
import 'package:green_bin/screens/done_order_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class BuyOldDataScreen extends StatefulWidget {
  const BuyOldDataScreen({Key? key}) : super(key: key);

  @override
  State<BuyOldDataScreen> createState() => _BuyOldDataScreenState();
}

class _BuyOldDataScreenState extends State<BuyOldDataScreen> {
  TextEditingController locationCotroller = TextEditingController();
  TextEditingController dateCotroller = TextEditingController();

  TextEditingController timeCotroller = TextEditingController();
  TextEditingController reminderCotroller = TextEditingController();

  var cardNumberController = TextEditingController();
  var expierdDateController = TextEditingController();
  var cvvController = TextEditingController();
  var nameOwnerController = TextEditingController();

  var firstFormKey = GlobalKey<FormState>();
  var secondFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostCleanerSucsessState) {
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
        if (state is AppPostCleanerErorrtate) {
          Fluttertoast.showToast(
              msg: "You Enter Invalid data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        locationCotroller.text = AppCubit.get(context).yourlocationSeleted ==
                null
            ? ' Add your location'
            : '${AppCubit.get(context).yourlocationSeleted?.street}  ,${AppCubit.get(context).yourlocationSeleted?.administrativeArea}';
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
                  builder: (context) => const BuyOldScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => Stepper(
              type: StepperType.horizontal,
              elevation: 0,
              margin: const EdgeInsets.all(0),
              steps: getSteps(cubit, context, constraints),
              currentStep: cubit.buyOldCurrnetStep,
              onStepContinue: () {
                final isLast = cubit.buyOldCurrnetStep ==
                    getSteps(cubit, context, constraints).length - 1;

                if (isLast) {
                  print('last');
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
                } else {
                  cubit.onContinueOldData();
                  cubit.totalMoneyBuyOld(
                    papers: cubit.paperKillos,
                    metals: cubit.metalKillos,
                    elec: cubit.elecKillos,
                  );
                }
              },
              onStepCancel: cubit.buyOldCurrnetStep == 0
                  ? null
                  : () {
                      cubit.buyOldCurrnetStep -= 1;
                    },
              onStepTapped: (step) {
                cubit.onStepTappedBuyOld(step);
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLast = cubit.buyOldCurrnetStep ==
                    getSteps(cubit, context, constraints).length - 1;

                return ConditionalBuilderRec(
                  condition: state is! AppPostCleanerLoadingState,
                  builder: (context) => FlatButton(
                    height: 60,
                    //    constraints.maxHeight * 0.01
                    child: Text(
                      isLast ? 'Send Requset' : 'Preview',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                    ),
                    color: deafaultColor,
                    onPressed: details.onStepContinue,
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<Step> getSteps(AppCubit cubit, context, BoxConstraints constraints) => [
        Step(
          isActive: cubit.buyOldCurrnetStep >= 0,
          state: cubit.buyOldCurrnetStep > 0
              ? StepState.complete
              : StepState.indexed,
          title: Text(
            'Order Data',
            style: TextStyle(
              color:
                  cubit.buyOldCurrnetStep == 0 ? deafaultColor : Colors.black54,
              fontSize: 13,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do You Want ?',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 15,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildItem(
                      imageUrl: 'assets/svg/cash.svg',
                      title: 'Cash',
                      tap: () => cubit.selectCash(),
                      type: cubit.cash,
                    ),
                  ),
                  Expanded(
                    child: buildItem(
                      imageUrl: 'assets/svg/coins.svg',
                      title: 'Points',
                      tap: () => cubit.selectPoints(),
                      type: cubit.points,
                    ),
                  ),
                  // Expanded(
                  //   child: buildItem(
                  //     imageUrl: 'assets/svg/donate.svg',
                  //     title: 'Donate',
                  //     tap: () => cubit.selectDonate(),
                  //     type: cubit.donate,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Location',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 5),
                Container(
                  color: ShadeColor,
                  child: deafualtTextformField(
                    controller: locationCotroller,
                    saved: (saved) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'location must not be empty';
                      }
                      return null;
                    },
                    enableborder: InputBorder.none,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MapScreeen(),
                      ));
                    },
                    obsecure: false,
                    icon: const Icon(
                      IconBroken.Location,

                      //size: 26,
                    ),
                    suffixicon: Icon(
                      Icons.my_location,
                      color: deafaultColor,
                      size: 21,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Date',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 5),
                Container(
                  color: ShadeColor,
                  child: deafualtTextformField(
                    controller: dateCotroller,
                    saved: (saved) {},
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        dateCotroller.text =
                            (DateFormat().add_yMd().format(value!));
                      }).catchError((error) {
                        print('error from reminder before arrival $error');
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'date must not be empty';
                      }
                      return null;
                    },
                    obsecure: false,
                    enableborder: InputBorder.none,
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Time',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 5),
                Container(
                  color: ShadeColor,
                  child: deafualtTextformField(
                    controller: timeCotroller,
                    saved: (saved) {},
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        timeCotroller.text = value!.format(context);
                      }).catchError((error) {
                        print('error from time packer $error ');
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'time must not be empty';
                      }
                      return null;
                    },
                    obsecure: false,
                    enableborder: InputBorder.none,
                    icon: const Icon(
                      Icons.watch_later_outlined,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Reminder before arrival',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 5),
                Container(
                  color: ShadeColor,
                  child: deafualtTextformField(
                    controller: reminderCotroller,
                    saved: (saved) {},
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        reminderCotroller.text = value!.format(context);
                      }).catchError((error) {
                        print('error from reminder before arrival $error');
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'reminder time must not be empty';
                      }
                      return null;
                    },
                    obsecure: false,
                    enableborder: InputBorder.none,
                    icon: const Icon(
                      Icons.alarm_outlined,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // deafaultButton(
                //   buttonColor: deafaultColor!,
                //   buttonText: 'Preview',
                //   onPressed: () {
                //     // Navigator.of(context).push(MaterialPageRoute(
                //     //   builder: (context) => BuyOldCheckOrder(),
                //     // ));
                //     AppCubit.get(context).saveOldProducts1(
                //       type: 'cash',
                //       location: locationCotroller.text,
                //       lat: '${UserLocation.lat}',
                //       lng: '${UserLocation.long}',
                //       date: dateCotroller.text,
                //       time: timeCotroller.text,
                //       reminderTime: reminderCotroller.text,
                //     );
                //     Navigator.of(context).push(
                //       PageTransition(
                //         child: BuyOldCheckOrder(),
                //         type: PageTransitionType.fade,
                //         alignment: Alignment.center,
                //         duration: const Duration(
                //           milliseconds: 800,
                //         ),
                //       ),
                //     );
                //   },
                //   context: context,
                // )
              ]),
              SizedBox(height: constraints.maxHeight * 0.2),
            ],
          ),
        ),
        Step(
          isActive: cubit.buyOldCurrnetStep >= 1,
          state: cubit.buyOldCurrnetStep > 1
              ? StepState.complete
              : StepState.indexed,
          title: Text(
            'Preview',
            style: TextStyle(
              color:
                  cubit.buyOldCurrnetStep == 1 ? deafaultColor : Colors.black54,
              fontSize: 13,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      cubit.returnToOrderBuyOld();
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
                              dateCotroller.text,
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
                              'assets/svg/location.svg',
                              height: 25,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              locationCotroller.text,
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
                              timeCotroller.text,
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
              Text(
                'Order',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 19,
                    ),
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
                        if (cubit.metalKillos != 0)
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
                                '${cubit.numberofMetalsrKillos} Kg',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        if (cubit.metalKillos != 0) const SizedBox(height: 12),
                        if (cubit.elecKillos != 0)
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
                                '${cubit.numberofElectronicsKillos} Kg',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        if (cubit.elecKillos != 0) const SizedBox(height: 12),
                        if (cubit.paperKillos != 0)
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
                                '${cubit.numberofPaperKillos} Kg',
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
                              '15 EGP',

                              // 200 point = 5 pound
                              // 200 point = 1 kg
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
                        SizedBox(height: constraints.maxHeight * 0.3),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ];

  Widget buildItem({
    required String imageUrl,
    required String title,
    required void Function() tap,
    required bool type,
  }) =>
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Card(
            elevation: 2,
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                tap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      color: type ? deafaultColor : Colors.black12,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const SizedBox(width: 4),

                  SvgPicture.asset(imageUrl), // image url
                  const SizedBox(width: 4),
                  Text(
                    title, // title
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
