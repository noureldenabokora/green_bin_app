import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/user_model.dart';
import 'package:green_bin/screens/forget_password_process/confirm_new_password.dart';
import 'package:green_bin/screens/forget_password_process/forget_password_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

class EmailVerficationScreen extends StatelessWidget {
  //const SmsVerficationScreen({Key? key}) : super(key: key);

  userModel model;

  EmailVerficationScreen(this.model);

  var codeContoller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppVerfiEmailsCodeSucsessState) {
          Fluttertoast.showToast(
            msg: "${state.model.data.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) {
            Navigator.of(context).push(
              PageTransition(
                child: ConfirmNewPassword(model),
                type: PageTransitionType.fade,
                alignment: Alignment.center,
                duration: const Duration(
                  milliseconds: 800,
                ),
              ),
            );
          });
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => HomeScreen(),
          // ));
        }
        if (state is AppVerfiyEmailCodeErorrtate) {
          Fluttertoast.showToast(
            msg: "Wrong active code",
            toastLength: Toast.LENGTH_SHORT,
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
                  builder: (context) => ForgetPasswordScreen(),
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
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'verification',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 30,
                          ),
                    ),
                    Text(
                      'Enter the code from the email we just sent you',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 13,
                            height: 1.6,
                            color: const Color(0xff565757),
                          ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    Pinput(
                      length: 5,
                      closeKeyboardWhenCompleted: true,
                      controller: codeContoller,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 60,
                        textStyle: const TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(30, 60, 87, 1),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: deafaultColor!,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      //               focusedPinTheme: PinTheme(
                      //                 width: 56,
                      //                 height: 60,
                      //                 textStyle: TextStyle(
                      //                   fontSize: 22,
                      //                   color: Color.fromRGBO(30, 60, 87, 1),
                      // //fontWeight: FontWeight.w600,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   border: Border.all(),
                      //                   borderRadius: BorderRadius.circular(20),
                      //                 ),
                      //               ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Row(
                      children: [
                        Text(
                          'Didn\'t receive code? ',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                    height: 1.3,
                                  ),
                        ),
                        TextButton(
                          child: Text(
                            'Resend code',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                      height: 1.3,
                                      color: deafaultColor,
                                    ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    ConditionalBuilderRec(
                      condition: state is! AppVerfiyEmailCodeLoadingState,
                      builder: (context) => deafaultButton(
                        buttonColor: deafaultColor!,
                        buttonText: 'verfiy',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubit.verfiyEmailCode(
                              uId: model.data.user_id,
                              emailCode: codeContoller.text,
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
            ),
          ),
        );
      },
    );
  }
}
