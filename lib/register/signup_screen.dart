import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/register/sms_verfication.dart';
import 'package:green_bin/screens/login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneContoller = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppRegisterSucsessState) {
          Fluttertoast.showToast(
            msg: "${state.model.data.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SmsVerficationScreen(
                state.model,
              ),
            ));
          });
        }
        if (state is AppRegisterErorrtate) {
          Fluttertoast.showToast(
            msg: "You Enter Invalid Data",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        //  height: constraints.maxHeight * 0.22,
                        child: Column(
                          children: [
                            FittedBox(
                              child: Text(
                                'Sign up',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 28,
                                      letterSpacing: 1.5,
                                    ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                'Enter your name, Email, Password for sign up.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 12,
                                      height: 1.9,
                                    ),
                              ),
                            ),
                            FittedBox(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                                },
                                child: Text(
                                  'Aleady have account ?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: deafaultColor,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildFormItem(context, cubit, constraints),
                      Container(
                        height: constraints.maxHeight * 0.04,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: const Color(0xffC8C8D5),
                              ),
                              child: Checkbox(
                                value: cubit.acceptTerms,
                                onChanged: (s) {
                                  cubit.acceptTermsCheckBox(s!);
                                },
                                checkColor: Colors.white,
                                activeColor: deafaultColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'By creating an account you agree to',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 6,
                                      letterSpacing: 0,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'The Terms of Service',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 8,
                                      color: deafaultColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.016),
                      ConditionalBuilderRec(
                        condition: state is! AppRegisterLoadingState,
                        builder: (context) => deafaultButton(
                          buttonColor: deafaultColor!,
                          buttonText: 'Sign Up',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.register(
                                name: nameController.text,
                                email: emailController.text,
                                mobile: phoneContoller.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          context: context,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        height: constraints.maxHeight * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: constraints.maxWidth * 0.09,
                              height: 1.5,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(width: constraints.maxWidth * 0.02),
                            Text(
                              'OR',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.02),
                            Container(
                              width: constraints.maxWidth * 0.09,
                              height: 1.5,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Container(
                        height: constraints.maxHeight * 0.1,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.loginWithGoogle();
                                },
                                child: Container(
                                  height: constraints.maxHeight * 0.054,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffCFCFCF),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/google.svg',
                                        height: 25,
                                      ),
                                      Text(
                                        'Google',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.02),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.loginWithFacebook();
                                },
                                child: Container(
                                  height: constraints.maxHeight * 0.054,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff3B5998),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.facebook_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text(
                                        'Facebook',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFormItem(context, AppCubit cubit, BoxConstraints constraints) =>
      Form(
        key: formKey,
        child: Container(
          //     height: constraints.maxHeight * 0.56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                    ),
              ),
              //       SizedBox(height: constraints.maxHeight * 0.002),
              Container(
                color: ShadeColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxHeight * 0.01,
                  ),
                  child: deafualtTextformField(
                    controller: nameController,
                    keybordtype: TextInputType.name,
                    saved: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name Must not be Empty';
                      }
                      return null;
                    },
                    obsecure: false,
                    enableborder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.01),

              Text(
                'Email',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                    ),
              ),

              Container(
                color: ShadeColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxHeight * 0.01,
                  ),
                  child: deafualtTextformField(
                    controller: emailController,
                    keybordtype: TextInputType.emailAddress,
                    saved: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email Must not be Empty';
                      }
                      return null;
                    },
                    obsecure: false,
                    enableborder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.01),

              Text(
                'Phone Number',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                    ),
              ),

              Container(
                color: ShadeColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxHeight * 0.01,
                  ),
                  child: deafualtTextformField(
                    controller: phoneContoller,
                    keybordtype: TextInputType.number,
                    saved: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Must not be Empty';
                      }
                      return null;
                    },
                    obsecure: false,
                    enableborder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.01),

              Text(
                'Password',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                    ),
              ),

              Container(
                color: ShadeColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxHeight * 0.01,
                  ),
                  child: deafualtTextformField(
                    controller: passwordController,
                    saved: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password Must not be Empty';
                      }
                      return null;
                    },
                    obsecure: cubit.registerPassword,
                    enableborder: InputBorder.none,
                    suffixicon: IconButton(
                      onPressed: () {
                        cubit.visableEyeRegisterPassword();
                      },
                      icon: Icon(
                        cubit.registerSufixicon,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
