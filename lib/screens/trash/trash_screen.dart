// import 'dart:ffi';

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
import 'package:green_bin/screens/cleaner/google.dart';
import 'package:green_bin/screens/done_order_screen.dart';
import 'package:green_bin/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class TrashScreen extends StatelessWidget {
  var formKey1 = GlobalKey<FormState>();

  var cardNumberController = TextEditingController();

  var expierdDateController = TextEditingController();

  var cvvController = TextEditingController();

  var nameOwnerController = TextEditingController();

  var timeController = TextEditingController();

  var reminderController = TextEditingController();

  var formKey2 = GlobalKey<FormState>();

  TrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostTrashSucsessState) {
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
        if (state is AppPostTrashErorrtate) {
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
        var cubit = AppCubit.get(context);
        var location = AppCubit.get(context).yourlocationSeleted == null
            ? 'Please Add your location'
            : '${AppCubit.get(context).yourlocationSeleted?.street}  ,${AppCubit.get(context).yourlocationSeleted?.administrativeArea}';

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
                  builder: (context) => const HomeScreen(),
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
              margin: EdgeInsetsGeometry.infinity,
              steps: getSteps(cubit, location, context, constraints),
              elevation: 0,
              type: StepperType.horizontal,
              currentStep: cubit.trashcurrnetStep,
              onStepContinue: () {
                final isLast = cubit.trashcurrnetStep ==
                    getSteps(cubit, location, context, constraints).length - 1;

                if (isLast) {
                  cubit.postTrash(
                    location: location,
                    lat: '${UserLocation.lat}',
                    lng: '${UserLocation.long}',
                    arrivalTime: timeController.text,
                    reminderTime: reminderController.text,
                    place: cubit.placeValueCleaner == 'Company' ? '1' : '2',
                    garbage: cubit.recycleValue == 'Recycable' ? '1' : '2',
                    planId: '1',
                    cardNumber: cardNumberController.text,
                    expireDate: expierdDateController.text,
                    cvv: cvvController.text,
                    holderName: nameOwnerController.text,
                  );
                } else {
                  cubit.onContinueTrash();
                }
              },
              onStepCancel: cubit.trashcurrnetStep == 0
                  ? null
                  : () {
                      cubit.trashcurrnetStep -= 1;
                    },
              onStepTapped: (step) {
                cubit.onStepTappedTrash(step);
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLast = cubit.trashcurrnetStep ==
                    getSteps(cubit, location, context, constraints).length - 1;

                return ConditionalBuilderRec(
                  condition: state is! AppPostTrashLoadingState,
                  builder: (context) => FlatButton(
                    height: 50,
                    child: Text(
                      isLast ? 'Send Requset' : 'Next',
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

  List<Step> getSteps(
          AppCubit cubit, var location, context, BoxConstraints constraints) =>
      [
        Step(
          isActive: cubit.trashcurrnetStep >= 0,
          state: cubit.trashcurrnetStep > 0
              ? StepState.complete
              : StepState.indexed,
          title: Text(
            'Order Data',
            style: TextStyle(
              color:
                  cubit.trashcurrnetStep == 0 ? deafaultColor : Colors.black54,
              fontSize: 10,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MapScreeen(),
                          ));
                        },
                        child: Text(
                          'Add location',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 13,
                                    color: deafaultColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.selcetLocation1();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: cubit.isChoosen1
                                    ? deafaultColor
                                    : Colors.black12,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              location == null
                                  ? 'Mansoura Hay AlGamaa'
                                  : '$location',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    color: cubit.isChoosen1
                                        ? Colors.black
                                        : Colors.black38,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      GestureDetector(
                        onTap: () {
                          cubit.selcetLocation2();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: cubit.isChoosen2
                                    ? deafaultColor
                                    : Colors.black12,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Mansoura, Elmashaya st ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    color: cubit.isChoosen2
                                        ? Colors.black
                                        : Colors.black38,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      GestureDetector(
                        onTap: () {
                          cubit.selcetLocation3();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: cubit.isChoosen3
                                    ? deafaultColor
                                    : Colors.black12,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Mansoura,Talkha',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    color: cubit.isChoosen3
                                        ? Colors.black
                                        : Colors.black38,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        color: ShadeColor,
                        child: deafualtTextformField(
                          controller: timeController,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(value!.format(context).toString());
                              String formattedTime =
                                  DateFormat('HH:mm:ss').format(parsedTime);

                              timeController.text = formattedTime;
                            }).catchError((error) {
                              print('error from time packer $error ');
                            });
                          },
                          saved: (saved) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Time must not be empty';
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
                      SizedBox(height: constraints.maxHeight * 0.02),
                      Text(
                        'Reminder before arrival',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        color: ShadeColor,
                        child: deafualtTextformField(
                          controller: reminderController,
                          saved: (saved) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Reminder Time must not be empty';
                            }
                            return null;
                          },
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(value!.format(context).toString());
                              String formattedTime =
                                  DateFormat('HH:mm:ss').format(parsedTime);

                              reminderController.text = formattedTime;
                            }).catchError((error) {
                              print(
                                  'error from reminder before arrival $error');
                            });
                          },
                          obsecure: false,
                          enableborder: InputBorder.none,
                          icon: const Icon(
                            Icons.alarm_outlined,
                            size: 26,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      Text(
                        'Place',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        height: constraints.maxHeight * 0.09,
                        color: ShadeColor,
                        child: DropdownButtonFormField(
                          dropdownColor: ShadeColor,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ShadeColor!,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ShadeColor!,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              prefixIcon: const Icon(
                                IconBroken.Work,
                                size: 26,
                              )),
                          items: cubit.items
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          hint: const Text('Choose your place'),
                          onChanged: (String? value) {
                            cubit.placeValueCleaner = value;
                          },
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      Text(
                        'Garbage',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        height: constraints.maxHeight * 0.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: ShadeColor,
                        ),
                        child: DropdownButtonFormField(
                          dropdownColor: ShadeColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ShadeColor!,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ShadeColor!,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            prefixIcon: const Icon(
                              IconBroken.Ticket_Star,
                              size: 26,
                            ),
                          ),
                          items: cubit.reucleItem
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          hint: const Text('Garbage'),
                          onChanged: (String? value) {
                            cubit.recycleValue = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),
                ],
              ),
            ),
          ),
        ),
        Step(
          title: Text(
            'Avilable Plans',
            style: TextStyle(
              color:
                  cubit.trashcurrnetStep == 1 ? deafaultColor : Colors.black54,
              fontSize: 10,
            ),
          ),
          isActive: cubit.trashcurrnetStep >= 1,
          state: cubit.trashcurrnetStep > 1
              ? StepState.complete
              : StepState.indexed,
          content: Column(
            children: [
              InkWell(
                onTap: () {
                  cubit.selectPlan1();
                },
                child: buildAvilablePlanItem(
                  'Popular',
                  '30 EGP/',
                  '8 Months',
                  cubit.selectedPlan1,
                  cubit,
                  context,
                  cubit.monthsPlanone,
                  (value) {
                    cubit.monthsPlanOneCheckBox(value);
                  },
                  cubit.daysperWeekPlanOne,
                  (value) {
                    cubit.daysPlanOneCheckBox(value);
                  },
                  cubit.gagggPlanOne,
                  (value) {
                    cubit.gggplanOneCheckBox(value);
                  },
                  constraints,
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.selectPlan2();
                },
                child: buildAvilablePlanItem(
                  'Special',
                  '20 EGP/',
                  '4 Months',
                  cubit.selectedPlan2,
                  cubit,
                  context,
                  cubit.monthsPlanTwo,
                  (value) {
                    cubit.monthsPlanTwoCheckBox(value);
                  },
                  cubit.daysperWeekPlanTwo,
                  (value) {
                    cubit.daysPlanTwoCheckBox(value);
                  },
                  cubit.gagggPlanTwo,
                  (value) {
                    cubit.ggPlanTwoCheckBox(value);
                  },
                  constraints,
                ),
              ),
              InkWell(
                onTap: () {
                  cubit.selectPlan3();
                },
                child: buildAvilablePlanItem(
                  'Normal',
                  '15 EGP/',
                  '1 Months',
                  cubit.selectedPlan3,
                  cubit,
                  context,
                  cubit.monthsPlanThree,
                  (value) {
                    cubit.monthsPlanThreeCheckBox(value);
                  },
                  cubit.daysperWeekPlanThree,
                  (value) {
                    cubit.daysPlanThreeCheckBox(value);
                  },
                  cubit.gagggPlanThree,
                  (value) {
                    cubit.ggPlanTwoCheckBox(value);
                  },
                  constraints,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.01),
            ],
          ),
        ),
        Step(
          title: Text(
            'Payment',
            style: TextStyle(
              color:
                  cubit.trashcurrnetStep == 2 ? deafaultColor : Colors.black54,
              fontSize: 10,
            ),
          ),
          isActive: cubit.trashcurrnetStep >= 2,
          state: cubit.trashcurrnetStep > 2
              ? StepState.complete
              : StepState.indexed,
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: deafaultColor!.withOpacity(0.2),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Text(
                          'Payment Details',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        Image(
                          width: double.infinity,
                          height: constraints.maxHeight * 0.1,
                          image: const AssetImage(
                            'assets/images/visa.png',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Form(
                  key: formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Text(
                        'Card Number',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        color: ShadeColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 5,
                        ),
                        child: deafualtTextformField(
                          controller: cardNumberController,
                          keybordtype: TextInputType.number,
                          saved: (saved) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please Enter Card Number';
                            }
                            return null;
                          },
                          hittext: 'Valid card Number',
                          suffixicon: const Icon(Icons.card_giftcard),
                          obsecure: false,
                          enableborder: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiration Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                SizedBox(height: constraints.maxHeight * 0.01),
                                Container(
                                  color: ShadeColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: deafualtTextformField(
                                      controller: expierdDateController,
                                      keybordtype: TextInputType.number,
                                      saved: (saved) {},
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2033),
                                        ).then((value) {
                                          expierdDateController.text =
                                              DateFormat('MM/yy')
                                                  .format(value!)
                                                  .toString();
                                        }).catchError((error) {
                                          print(
                                              'errror from date of birth $error');
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Expiration Date';
                                        }
                                        return null;
                                      },
                                      hittext: 'MM / YY',
                                      obsecure: false,
                                      enableborder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CV Code',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                SizedBox(height: constraints.maxHeight * 0.01),
                                Container(
                                  color: ShadeColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    child: deafualtTextformField(
                                      controller: cvvController,
                                      keybordtype: TextInputType.number,
                                      saved: (saved) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Cv Code';
                                        }
                                        return null;
                                      },
                                      hittext: 'Cv Code',
                                      obsecure: false,
                                      enableborder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Text(
                        'Card Owner',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        color: ShadeColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 5,
                        ),
                        child: deafualtTextformField(
                          controller: nameOwnerController,
                          saved: (saved) {},
                          keybordtype: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Card owner';
                            }
                            return null;
                          },
                          hittext: 'Card owner ',
                          obsecure: false,
                          enableborder: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.14),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            title: Text(
              'Preview',
              style: TextStyle(
                color: cubit.trashcurrnetStep == 3
                    ? deafaultColor
                    : Colors.black54,
                fontSize: 10,
              ),
            ),
            isActive: cubit.trashcurrnetStep >= 3,
            state: cubit.trashcurrnetStep > 3
                ? StepState.complete
                : StepState.indexed,
            content: Container(
              height: constraints.maxHeight * 0.77,
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
                          cubit.returnToOrderTrash();
                        },
                        icon: const Icon(
                          IconBroken.Edit,
                          size: 26,
                          color: Color(0xff686874),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: constraints.maxHeight * 0.3,
                    child: Stack(
                      children: [
                        Card(
                          elevation: 10,
                          child: Container(
                            height: constraints.maxHeight * 0.27,
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
                                    height: constraints.maxHeight * 0.03,
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.02),
                                  Text(
                                    cubit.placeValueCleaner != null
                                        ? '${cubit.placeValueCleaner}'
                                        : 'Please Select your Place',
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
                                  const Icon(
                                    IconBroken.Location,
                                    color: Color(0xff686874),
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.02),
                                  Text(
                                    '$location',
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
                                  const Icon(
                                    Icons.schedule_outlined,
                                    color: Color(0xff686874),
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.02),
                                  Text(
                                    timeController.text != null
                                        ? timeController.text
                                        : 'Please Add your Time',
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
                                    'assets/svg/reminder.svg',
                                    height: 25,
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.02),
                                  Text(
                                    reminderController.text,
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
                                    'assets/svg/recycle.svg',
                                    height: constraints.maxHeight * 0.03,
                                  ),
                                  SizedBox(width: constraints.maxWidth * 0.02),
                                  Text(
                                    cubit.recycleValue != null
                                        ? '${cubit.recycleValue}'
                                        : 'Please Select your Categorie',
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
                  ),
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
                          cubit.returnToAvaliablePlan();
                        },
                        icon: const Icon(
                          IconBroken.Edit,
                          size: 26,
                          color: Color(0xff686874),
                        ),
                      ),
                    ],
                  ),
                  if (cubit.selectedPlan1 == true)
                    buildCheckOrderItem(
                      title: 'Popular',
                      moneyForMonth: '30 EGP/',
                      time: '8 Month',
                      context: context,
                      selecetd: true,
                      height: constraints.maxHeight * 0.27,
                      moneyheight: constraints.maxHeight * 0.1,
                      moneywidth: constraints.maxWidth * 0.27,
                    ),
                  if (cubit.selectedPlan2 == true)
                    buildCheckOrderItem(
                      title: 'Special',
                      moneyForMonth: '20 EGP/',
                      time: '4 Month',
                      context: context,
                      selecetd: true,
                      height: constraints.maxHeight * 0.2,
                      moneyheight: constraints.maxHeight * 0.1,
                      moneywidth: constraints.maxWidth * 0.27,
                    ),
                  if (cubit.selectedPlan3 == true)
                    buildCheckOrderItem(
                      title: 'Normal',
                      moneyForMonth: '15 EGP/',
                      time: '1 Month',
                      context: context,
                      selecetd: true,
                      height: constraints.maxHeight * 0.2,
                      moneyheight: constraints.maxHeight * 0.1,
                      moneywidth: constraints.maxWidth * 0.27,
                    ),
                ],
              ),
            )),
      ];

  Widget buildAvilablePlanItem(
    String title,
    String moneyForMonth,
    String time,
    bool selecetd,
    AppCubit cubit,
    context,
    bool valueone,
    void Function(bool value) month,
    bool valuetwo,
    void Function(bool value) days,
    bool valueThree,
    void Function(bool value) grab,
    BoxConstraints constraints,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          //   horizontal: 8,
          vertical: constraints.maxHeight * 0.01,
        ),
        child: Stack(
          children: [
            Card(
              elevation: 2,
              child: Container(
                height: constraints.maxHeight * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      selecetd ? deafaultColor!.withOpacity(0.3) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.04,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: selecetd ? deafaultColor : Colors.grey[400],
                      ),
                    ),
                    Text(
                      selecetd ? 'Applied' : 'Apply',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: selecetd ? Colors.white : Colors.black45,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxHeight * 0.02,
                    vertical: constraints.maxHeight * 0.02,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title, //title
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.01),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 30,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffC8C8D5),
                                      ),
                                      child: Checkbox(
                                        value: valueone, // cubit.monthsPlanone,
                                        onChanged: (v) {
                                          month(v!);
                                          //   /ss,cubit.monthsPlanOneCheckBox(v!);
                                        },
                                        checkColor: Colors.white,
                                        activeColor: deafaultColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      time, //time
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 14,
                                            color: selecetd
                                                ? deafaultColor
                                                : Colors.black54,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 30,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffC8C8D5),
                                      ),
                                      child: Checkbox(
                                        value: valuetwo,
                                        //cubit.daysperWeekPlanOne,
                                        onChanged: (v) {
                                          days(v!);
                                          //  cubit.daysPlanOneCheckBox(v!);
                                        },
                                        checkColor: Colors.white,
                                        activeColor: deafaultColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      '5 Days/ Week',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 14,
                                            color: selecetd
                                                ? deafaultColor
                                                : Colors.black54,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 30,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffC8C8D5),
                                      ),
                                      child: Checkbox(
                                        value: valueThree,

                                        //cubit.gagggPlanOne,
                                        onChanged: (v) {
                                          grab(v!);
                                          //   cubit.gggplanOneCheckBox(v!);
                                        },
                                        checkColor: Colors.white,
                                        activeColor: deafaultColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      '30 Garbage',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 14,
                                            color: selecetd
                                                ? deafaultColor
                                                : Colors.black54,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: constraints.maxHeight * 0.1,
                                width: constraints.maxWidth * 0.27,
                                decoration: BoxDecoration(
                                  color: selecetd
                                      ? deafaultColor
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    moneyForMonth, //money for month

                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 15,
                                          color: selecetd
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                  ),
                                  Text(
                                    'month',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 12,
                                          color: selecetd
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
