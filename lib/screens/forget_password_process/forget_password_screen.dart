import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/forget_password_process/email_verification.dart';
import 'package:green_bin/screens/login/login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
//  const ForgetPasswordScreen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSendForgetCofeSucsessState) {
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
              builder: (context) => EmailVerficationScreen(
                state.model,
              ),
            ));
          });
        }
        if (state is AppSendForgetCofeErorrtate) {
          Fluttertoast.showToast(
            msg: "Please enter valid email",
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Forget Password',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 22,
                          letterSpacing: 1.6,
                          height: 1.9,
                        ),
                  ),
                  Text(
                    'Please enter your Email so we can help you recover your password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          height: 1.5,
                          color: const Color(0Xff565757),
                        ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Container(
                          color: ShadeColor,
                          child: deafualtTextformField(
                            controller: emailController,
                            onTap: () {},
                            saved: (saved) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
                              }
                              return null;
                            },
                            obsecure: false,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 35),
                        ConditionalBuilderRec(
                          condition: state is! AppSendForgetCofeLoadingState,
                          builder: (context) => deafaultButton(
                            buttonColor: deafaultColor!,
                            buttonText: 'Reset Passeord',
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                AppCubit.get(context).sendEmailForgetPassword(
                                  email: emailController.text,
                                );
                              }
                            },
                            context: context,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
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
