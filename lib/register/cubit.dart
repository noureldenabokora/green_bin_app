// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:green_bin/const/end_points.dart';
// import 'package:green_bin/cubit/states.dart';
// import 'package:green_bin/models/user_model.dart';
// import 'package:green_bin/register/states.dart';
// import 'package:green_bin/shared/dio_helper.dart';

// class AppRegisterCubit extends Cubit<AppRegisetrStates> {
//   AppRegisterCubit() : super(AppRegisterIntialState());

//   static AppRegisterCubit get(context) => BlocProvider.of(context);

//   // late userModel user;

//   // void register({
//   //   required String name,
//   //   required String email,
//   //   required String mobile,
//   //   required String password,
//   // }) {
//   //   emit(AppRegisterLoadingState());
//   //   DioHelper.postData(
//   //     url: REGISTER,
//   //     data: {
//   //       'name': name,
//   //       'email': email,
//   //       'mobile': mobile,
//   //       'password': password,
//   //       'firebase_token': firebasetoken,
//   //     },
//   //   ).then((value) {
//   //     user = userModel.FromJson(value.data);
//   //     print(value.data);
//   //     print(user.data.user_id);

//   //     print(user.data.message);
//   //     emit(AppRegisterSucsessState());
//   //   }).catchError((erorr) {
//   //     print(erorr.toString());
//   //     emit(AppRegisterErorrtate());
//   //   });
//   // }

//   // void verfiySmsCode({
//   //   required int? uId,
//   //   required String smsCode,
//   // }) {
//   //   emit(AppVerfiySmsCodeLoadingState());
//   //   DioHelper.postData(
//   //     url: SMSCODE,
//   //     data: {
//   //       'user_id': uId,
//   //       'active_code': smsCode,
//   //     },
//   //   ).then((value) {
//   //     print(value.data);
//   //     user = userModel.FromJson(value.data);
//   //     emit(AppVerfiySmsCodeSucsessState(user));
//   //   }).catchError((erorr) {
//   //     print(erorr.toString());
//   //     emit(AppVerfiySmsCodeErorrtate());
//   //   });
//   // }
// }
