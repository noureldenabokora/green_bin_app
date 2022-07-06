import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/cleaner/cleaner_checkorder_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class PaymentScreen extends StatelessWidget {
  var cardNumberController = TextEditingController();
  var expierdDateController = TextEditingController();
  var cvvController = TextEditingController();
  var nameOwnerController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: deafaultColor!.withOpacity(0.2),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              'Payment Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 25,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            const Image(
                              width: 380,
                              height: 110,
                              image: AssetImage(
                                'assets/images/visa.png',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card Number',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 18,
                                    ),
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 5,
                            ),
                            child: deafualtTextformField(
                              controller: cardNumberController,
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
                          const SizedBox(height: 20),
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
                                    const SizedBox(height: 10),
                                    Container(
                                      color: Colors.grey.shade200,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        child: deafualtTextformField(
                                          controller: expierdDateController,
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
                                    const SizedBox(height: 10),
                                    Container(
                                      color: Colors.grey.shade200,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        child: deafualtTextformField(
                                          controller: cvvController,
                                          saved: (saved) {},
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Cv Code';
                                            }
                                            return null;
                                          },
                                          hittext: 'Cv Code',
                                          // suffixicon: Icon(Icons.card_giftcard),
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
                          const SizedBox(height: 15),
                          Text(
                            'Card Owner',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.grey.shade200,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 5,
                            ),
                            child: deafualtTextformField(
                              controller: nameOwnerController,
                              saved: (saved) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Card owner';
                                }
                                return null;
                              },
                              hittext: 'Card owner ',
                              // suffixicon: Icon(Icons.card_giftcard),
                              obsecure: false,
                              enableborder: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 20),
                          deafaultButton(
                            buttonColor: deafaultColor!,
                            buttonText: 'Confirm Payment',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // AppCubit.get(context).saveCleaner2(
                                //   card_number: cardNumberController.text,
                                //   expire_date: expierdDateController.text,
                                //   cvv: cvvController.text,
                                //   holder_name: nameOwnerController.text,
                                // );
                                // Navigator.of(context).push(
                                //   PageTransition(
                                //     child: const cleanerCheckOrderScreen(),
                                //     type: PageTransitionType.fade,
                                //     alignment: Alignment.center,
                                //     duration: const Duration(
                                //       milliseconds: 800,
                                //     ),
                                //   ),
                                // );
                              }
                            },
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
