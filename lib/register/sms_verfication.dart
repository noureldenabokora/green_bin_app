import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/user_model.dart';
import 'package:green_bin/register/signup_screen.dart';
import 'package:green_bin/screens/home_screen.dart';
import 'package:green_bin/shared/cache_helper.dart';
import 'package:pinput/pinput.dart';

class SmsVerficationScreen extends StatelessWidget {
  //const SmsVerficationScreen({Key? key}) : super(key: key);

  userModel model;

  SmsVerficationScreen(this.model, {Key? key}) : super(key: key);

  var smsContoller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppVerfiySmsCodeSucsessState) {
          Fluttertoast.showToast(
            msg: "${state.model.data.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          CacheHellper.setData(
            key: 'apiToken',
            value: state.model.data.data?.user_api_token,
          ).then((value) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
          });

          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => HomeScreen(),
          // ));
        }
        if (state is AppVerfiySmsCodeErorrtate) {
          Fluttertoast.showToast(
            msg: "Wrong active code",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
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
                  builder: (context) => SignUpScreen(),
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
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Text(
                      'verification',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 30,
                          ),
                    ),
                    Text(
                      'Enter the OTP code from the phone we just sent you at ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 13,
                            height: 1.6,
                          ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Text(
                      '01110702310',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 14,
                            height: 1.3,
                            color: deafaultColor,
                          ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Pinput(
                      // obscureText: true,
                      length: 5,
                      closeKeyboardWhenCompleted: true,
                      //cursor: ,
                      controller: smsContoller,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 60,
                        textStyle: const TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          //fontWeight: FontWeight.w600,
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
                        FittedBox(
                          child: Text(
                            'Didn\'t receive code? ',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 14,
                                      height: 1.3,
                                    ),
                          ),
                        ),
                        FittedBox(
                          child: TextButton(
                            child: Text(
                              'Resend code',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                    height: 1.3,
                                    color: deafaultColor,
                                  ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    ConditionalBuilderRec(
                      condition: state is! AppVerfiySmsCodeLoadingState,
                      builder: (context) => deafaultButton(
                        buttonColor: deafaultColor!,
                        buttonText: 'verfiy',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubit.verfiySmsCode(
                              uId: model.data.user_id,
                              smsCode: smsContoller.text,
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
