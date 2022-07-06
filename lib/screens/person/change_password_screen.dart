import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/home_screen.dart';
import 'package:green_bin/screens/person/person_screen.dart';
import 'package:page_transition/page_transition.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  var currentPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdatePasswordSucsessState) {
          Fluttertoast.showToast(
            msg: "Password Updated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) {
            Navigator.of(context).push(
              PageTransition(
                child: HomeScreen(),
                type: PageTransitionType.fade,
                alignment: Alignment.center,
                duration: const Duration(
                  milliseconds: 800,
                ),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: PersonScreen(),
                    type: PageTransitionType.fade,
                    alignment: Alignment.center,
                    duration: const Duration(
                      milliseconds: 800,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text(
                          'Change password',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 22,
                                  ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.01),
                            Container(
                              color: ShadeColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 5,
                                ),
                                child: deafualtTextformField(
                                  controller: currentPassword,
                                  saved: (saved) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Current password must not be empty';
                                    }
                                    return null;
                                  },
                                  obsecure: cubit.currentPassword,
                                  enableborder: InputBorder.none,
                                  suffixicon: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context)
                                          .visableEyeCurrentPassword();
                                    },
                                    icon: Icon(
                                      cubit.sufixicon1,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            Text(
                              'New password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.01),
                            Container(
                              color: ShadeColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 5,
                                ),
                                child: deafualtTextformField(
                                  controller: newPassword,
                                  saved: (saved) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'New password must not be empty';
                                    }
                                    return null;
                                  },
                                  obsecure:
                                      AppCubit.get(context).changePassword,
                                  enableborder: InputBorder.none,
                                  suffixicon: IconButton(
                                    onPressed: () {
                                      cubit.visableEyeChangePassword();
                                    },
                                    icon: Icon(
                                      cubit.sufixicon2,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            Text(
                              'Confirm password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: ShadeColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 5,
                                ),
                                child: deafualtTextformField(
                                  controller: confirmPassword,
                                  saved: (saved) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Confirm password must not be empty';
                                    }
                                    return null;
                                  },
                                  obsecure: cubit.secondchangePassword,
                                  enableborder: InputBorder.none,
                                  suffixicon: IconButton(
                                    onPressed: () {
                                      cubit.visableEyeSecondChangePassword();
                                    },
                                    icon: Icon(
                                      cubit.sufixicon3,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.3),
                            ConditionalBuilderRec(
                              condition:
                                  state is! AppUpdatePasswordLoadingState,
                              builder: (context) => deafaultButton(
                                buttonColor: deafaultColor!,
                                buttonText: 'Save',
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    cubit.updatePassword(
                                      currentPassword: currentPassword.text,
                                      newPassword: newPassword.text,
                                      confirmPassword: confirmPassword.text,
                                    );
                                  }
                                },
                                context: context,
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
