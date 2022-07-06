import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/register/signup_screen.dart';
import 'package:green_bin/screens/forget_password_process/forget_password_screen.dart';
import 'package:green_bin/screens/home_screen.dart';
import 'package:green_bin/shared/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLoginSucsessState) {
          Fluttertoast.showToast(
              msg: "${state.model.data.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: deafaultColor,
              textColor: Colors.white,
              fontSize: 16.0);

          CacheHellper.setData(
            key: 'apiToken',
            value: state.model.data.data?.user_api_token,
          ).then((value) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
          });
        }

        if (state is AppLoginWithFacebookSucsessState) {
          Fluttertoast.showToast(
            msg: "facbook login sucessfully ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }

        if (state is AppLoginWithGoogleSucsessState) {
          Fluttertoast.showToast(
            msg: "google login sucessfully ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));

          print(AppCubit.get(context).googleAccount!.email);
        }
        if (state is AppLoginErorrtate) {
          Fluttertoast.showToast(
              msg: "you enter Invalid data ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: deafaultColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var height = MediaQuery.of(context).size.height;
        var wedith = MediaQuery.of(context).size.width;

        var cubit = AppCubit.get(context);
        var model = cubit.currentUser;
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.1),
                        Text(
                          'Welcome',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 30,
                                    letterSpacing: 1.5,
                                  ),
                        ),
                        Text(
                          'Login to your account to receive rewards and save your details for a faster checkout experience',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.06),
                        Container(
                          color: ShadeColor,
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
                            lable: 'Email',
                            obsecure: false,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Container(
                          color: ShadeColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxHeight * 0.01,
                          ),
                          child: deafualtTextformField(
                            controller: passwordController,
                            saved: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password is too Short';
                              }
                              return null;
                            },
                            lable: 'password',
                            suffixicon: IconButton(
                              onPressed: () {
                                cubit.visableEyeLoginPassword();
                              },
                              icon: Icon(
                                cubit.loginSufixicon,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            obsecure: cubit.loginPassword,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: const Color(0xffF2F2F5),
                              ),
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: deafaultColor,
                                value: cubit.rememberMe,
                                onChanged: (value) {
                                  cubit.remmeberMeCheckBox(value!);
                                },
                              ),
                            ),
                            const FittedBox(
                              child: Text(
                                'Remmember me ',
                              ),
                            ),
                            const Spacer(),
                            Container(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ));
                                },
                                child: FittedBox(
                                  child: Text(
                                    'Forget Password',
                                    style: TextStyle(
                                      color: deafaultColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        ConditionalBuilderRec(
                          condition: state is! AppLoginLoadingState,
                          builder: (context) => deafaultButton(
                              buttonColor: deafaultColor!,
                              buttonText: 'Sign In',
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  AppCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              context: context),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          children: [
                            const FittedBox(
                              child: Text(
                                'Not a member yet? ',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                              },
                              child: Text(
                                'Sign Up ',
                                style: TextStyle(
                                  color: deafaultColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        const Center(
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        ConditionalBuilderRec(
                          condition: state is! AppLoginWithFacebookLoadingState,
                          builder: (context) => GestureDetector(
                            onTap: () {
                              cubit.loginWithFacebook();
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.07,
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xff3B5998),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.facebook_outlined,
                                    color: Colors.white,
                                    size: constraints.maxHeight * 0.04,
                                  ),
                                  const Text(
                                    'Continue with Facebook',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        ConditionalBuilderRec(
                          condition: state is! AppLoginWithGoogleLoadingState,
                          builder: (context) => GestureDetector(
                            onTap: () {
                              cubit.loginWithGoogle();
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.07,
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
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
                                  ),
                                  const Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
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
