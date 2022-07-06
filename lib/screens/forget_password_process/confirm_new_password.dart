import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/user_model.dart';
import 'package:green_bin/screens/login/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class ConfirmNewPassword extends StatelessWidget {
  // const ConfirmNewPassword({Key? key}) : super(key: key);

  userModel model;

  ConfirmNewPassword(this.model, {Key? key}) : super(key: key);

  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppConfirmPasswordSucsessState) {
          Fluttertoast.showToast(
            msg: "password changed successfully, please try to login now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) {
            Navigator.of(context).push(
              PageTransition(
                child: LoginScreen(),
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
                Navigator.of(context).pop();
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
                          'Confirm password',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 23,
                                    letterSpacing: 1.2,
                                  ),
                        ),
                        Text(
                          'please enter your new password ',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                    height: 1.9,
                                    color: const Color(0xff565757),
                                  ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'password',
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
                              child: deafualtTextformField(
                                controller: newPassword,
                                saved: (saved) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Current password must not be empty';
                                  }
                                  return null;
                                },
                                obsecure: cubit.restnewPassword,
                                enableborder: InputBorder.none,
                                suffixicon: IconButton(
                                  onPressed: () {
                                    cubit.visableEyeRestNewPassword();
                                  },
                                  icon: Icon(
                                    cubit.restNewsufixicon,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.03),
                            Text(
                              'Confirm password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.01),
                            Container(
                              color: const Color(0xffF2F2F5),
                              child: deafualtTextformField(
                                controller: confirmPassword,
                                saved: (saved) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'New password must not be empty';
                                  }
                                  return null;
                                },
                                obsecure: cubit.confirmNewPassword,
                                enableborder: InputBorder.none,
                                suffixicon: IconButton(
                                  onPressed: () {
                                    cubit.visableEyeConfirmRestNewPassword();
                                  },
                                  icon: Icon(
                                    cubit.confirmrRestSufixicon,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.4),
                            ConditionalBuilderRec(
                              condition:
                                  state is! AppConfirmPasswordLoadingState,
                              builder: (context) => deafaultButton(
                                buttonColor: deafaultColor!,
                                buttonText: 'Save',
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    AppCubit.get(context).confirmPassword(
                                      userId: model.data.user_id,
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
