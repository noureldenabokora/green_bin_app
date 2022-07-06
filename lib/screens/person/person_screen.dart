import 'dart:io';

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/person/change_password_screen.dart';
import 'package:green_bin/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class PersonScreen extends StatelessWidget {
  //const PersonScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  var dateController = TextEditingController();

  var phoneContoller = TextEditingController();

  var emailContoller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isChoosen1 = false;
  bool isChoosen2 = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdateProfileSucsessState) {
          Fluttertoast.showToast(
            msg: "Porfile updated Sucsessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
          });
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var user = cubit.user?.data.data;
        nameController.text = user!.user_name!;
        dateController.text = user.user_birth_date!;
        phoneContoller.text = user.user_mobile!;
        emailContoller.text = user.user_email!;

        var image = cubit.image;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'My Profile',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        backgroundImage: image == null
                            ? NetworkImage(
                                ('${user.user_image}'),
                              )
                            : FileImage(image) as ImageProvider,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: deafaultColor!.withOpacity(0.4),
                        child: IconButton(
                            onPressed: () {
                              AppCubit.get(context).pickedProfileImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo_outlined,
                              color: deafaultColor,
                              size: 16,
                            )),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: ChangePasswordScreen(),
                          type: PageTransitionType.fade,
                          alignment: Alignment.center,
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: deafaultColor,
                      ),
                    ),
                  ),
                  //    const SizedBox(height: 8),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full name',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          color: ShadeColor,
                          child: deafualtTextformField(
                            controller: nameController,
                            saved: (s) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            obsecure: false,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Date of birth',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          color: ShadeColor,
                          child: deafualtTextformField(
                            controller: dateController,
                            saved: (s) {},
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2033),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMd().format(value!).toString();
                              }).catchError((error) {
                                print('errror from date of birth $error');
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'date of birth must not be empty';
                              }
                              return null;
                            },
                            obsecure: false,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gender',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.selectMale();
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: ShadeColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            color: cubit.ismale ||
                                                    cubit.user?.data.data
                                                            ?.user_gender ==
                                                        'male'
                                                ? deafaultColor
                                                : Colors.white60,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        Text(
                                          'Male',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 16,
                                                color: cubit.ismale ||
                                                        cubit.user?.data.data
                                                                ?.user_gender ==
                                                            'male'
                                                    ? Colors.black
                                                    : Colors.black38,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //    isChoosen2 = !isChoosen2;
                                  //   user.user_gender == 'female';
                                  cubit.selectFemale();
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: ShadeColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            color: cubit.female ||
                                                    cubit.user?.data.data
                                                            ?.user_gender !=
                                                        'male'
                                                ? deafaultColor
                                                : Colors.white60,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        Text(
                                          'Female',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 16,
                                                color: cubit.female ||
                                                        cubit.user?.data.data
                                                                ?.user_gender !=
                                                            'male'
                                                    ? Colors.black
                                                    : Colors.black38,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mobile Number',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          color: ShadeColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            //  vertical: 4,
                          ),
                          child: deafualtTextformField(
                            controller: phoneContoller,
                            saved: (s) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'mobile number must not be empty';
                              }
                              return null;
                            },
                            obsecure: false,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          color: ShadeColor,
                          child: deafualtTextformField(
                            controller: emailContoller,
                            saved: (s) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            obsecure: false,
                            enableborder: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ConditionalBuilderRec(
                          condition: state is! AppUpdateProfileLoadingState,
                          builder: (context) => deafaultButton(
                            buttonColor: deafaultColor!,
                            buttonText: 'Save',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).updateProfile(
                                  name: nameController.text,
                                  birth_date: dateController.text,
                                  mobile: phoneContoller.text,
                                  email: emailContoller.text,
                                  gender: cubit.ismale ? 'male' : 'female',
                                  image: '',
                                );
                              }
                            },
                            context: context,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        )
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
