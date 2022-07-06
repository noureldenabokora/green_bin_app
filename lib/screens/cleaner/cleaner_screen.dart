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

class CleanerScreen extends StatelessWidget {
  CleanerScreen({Key? key}) : super(key: key);
  var locationCotroller = TextEditingController();
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
        var cubit = AppCubit.get(context);
        locationCotroller.text = AppCubit.get(context).yourlocationSeleted ==
                null
            ? ' Add your location'
            : '${AppCubit.get(context).yourlocationSeleted?.street}  ,${AppCubit.get(context).yourlocationSeleted?.administrativeArea}';

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Cleaners',
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
              type: StepperType.horizontal,
              elevation: 0,
              margin: const EdgeInsets.all(0),
              steps: getSteps(cubit, context, constraints),
              currentStep: cubit.cleanerCurrnetStep,
              onStepContinue: () {
                final isLast = cubit.cleanerCurrnetStep ==
                    getSteps(cubit, context, constraints).length - 1;

                if (isLast) {
                  cubit.postCleaner(
                    plcae: cubit.placeValueCleaner == 'Company' ? '1' : '2',
                    location: locationCotroller.text,
                    lat: '${UserLocation.lat}',
                    lng: '${UserLocation.long}',
                    ordertype: '1',
                    total: '1500',
                    card_number: cardNumberController.text,
                    expire_date: expierdDateController.text,
                    cvv: cvvController.text,
                    holder_name: nameOwnerController.text,
                  );
                } else {
                  cubit.onContinueCleaner();
                }
              },
              onStepCancel: cubit.cleanerCurrnetStep == 0
                  ? null
                  : () {
                      cubit.cleanerCurrnetStep -= 1;
                    },
              onStepTapped: (step) {
                cubit.onStepTappedCleaner(step);
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                final isLast = cubit.cleanerCurrnetStep ==
                    getSteps(cubit, context, constraints).length - 1;

                return ConditionalBuilderRec(
                  condition: state is! AppPostCleanerLoadingState,
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

  List<Step> getSteps(AppCubit cubit, context, BoxConstraints constraints) => [
        Step(
          isActive: cubit.cleanerCurrnetStep >= 0,
          state: cubit.cleanerCurrnetStep > 0
              ? StepState.complete
              : StepState.indexed,
          title: Text(
            'Order Data',
            style: TextStyle(
              color: cubit.cleanerCurrnetStep == 0
                  ? deafaultColor
                  : Colors.black54,
              fontSize: 12,
            ),
          ),
          content: Container(
            height: constraints.maxHeight * 0.77,
            child: Form(
              key: firstFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Place',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Container(
                    height: constraints.maxHeight * 0.09,
                    decoration: BoxDecoration(
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
                          Icons.api_outlined,
                          color: Color(0xff686874),
                        ),
                      ),
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
                    'Location',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxHeight * 0.01,
                      vertical: constraints.maxHeight * 0.01,
                    ),
                    color: ShadeColor,
                    child: deafualtTextformField(
                      controller: locationCotroller,
                      saved: (saved) {},
                      onChange: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please select your location';
                        }
                        return null;
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreeen(),
                        ));
                      },
                      enableborder: InputBorder.none,
                      obsecure: false,
                      icon: const Icon(
                        IconBroken.Location,
                        size: 26,
                      ),
                      suffixicon: Icon(
                        Icons.my_location,
                        color: deafaultColor,
                        size: 21,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Text(
                    'order Type',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Container(
                    height: constraints.maxHeight * 0.09,
                    decoration: BoxDecoration(
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
                          borderSide: BorderSide(color: ShadeColor!),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        prefixIcon: const Icon(
                          IconBroken.Document,
                          color: Color(0xff686874),
                        ),
                      ),
                      items: cubit.itemmoney
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      value: cubit.currentValuemoney,
                      onChanged: (String? value) {
                        cubit.currentValuemoney = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
          isActive: cubit.cleanerCurrnetStep >= 1,
          state: cubit.cleanerCurrnetStep > 1
              ? StepState.complete
              : StepState.indexed,
          title: Text(
            'payment',
            style: TextStyle(
              color: cubit.cleanerCurrnetStep == 1
                  ? deafaultColor
                  : Colors.black54,
              fontSize: 12,
            ),
          ),
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
                  key: secondFormKey,
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
                                      keybordtype: TextInputType.datetime,
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
                          keybordtype: TextInputType.name,
                          saved: (saved) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Card owner';
                            }
                            return null;
                          },
                          hittext: 'Card owner',
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
          isActive: cubit.cleanerCurrnetStep >= 2,
          state: cubit.cleanerCurrnetStep > 2
              ? StepState.complete
              : StepState.indexed,
          title: Text(
            'Preview',
            style: TextStyle(
              color: cubit.cleanerCurrnetStep == 2
                  ? deafaultColor
                  : Colors.black54,
              fontSize: 12,
            ),
          ),
          content: Container(
            height: constraints.maxHeight * 0.77,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Order Data ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 17,
                          ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        cubit.returnToOrderCleaner();
                      },
                      icon: const Icon(
                        IconBroken.Edit,
                        color: Color(0xff686874),
                        size: 26,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: Stack(
                    children: [
                      Card(
                        elevation: 10,
                        child: Container(
                          height: constraints.maxHeight * 0.18,
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
                                  color: const Color(0xff686874),
                                  height: constraints.maxHeight * 0.03,
                                ),
                                SizedBox(width: constraints.maxWidth * 0.02),
                                Text(
                                  '${cubit.placeValueCleaner}',
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
                            SizedBox(height: constraints.maxHeight * 0.01),
                            Row(
                              children: [
                                const Icon(
                                  IconBroken.Document,
                                  color: Color(0xff686874),
                                ),
                                SizedBox(width: constraints.maxWidth * 0.02),
                                Text(
                                  'Monthly',
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
                SizedBox(height: constraints.maxHeight * 0.01),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.black,
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    const Spacer(),
                    Text(
                      '1500 EGP/ Month',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 17,
                            color: deafaultColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ];
}
