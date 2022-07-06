// import 'package:conditional_builder_rec/conditional_builder_rec.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:green_bin/const/const.dart';
// import 'package:green_bin/const/iconbroken.dart';
// import 'package:green_bin/cubit/cubit.dart';
// import 'package:green_bin/cubit/states.dart';
// import 'package:green_bin/screens/cleaner/cleaner_screen.dart';
// import 'package:green_bin/screens/done_order_screen.dart';
// import 'package:green_bin/screens/payment_screen.dart';
// import 'package:page_transition/page_transition.dart';

// class cleanerCheckOrderScreen extends StatelessWidget {
//   const cleanerCheckOrderScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {
//         if (state is AppPostCleanerSucsessState) {
//           Navigator.of(context).push(
//             PageTransition(
//               child: const DoneOrderSCreen(),
//               type: PageTransitionType.fade,
//               alignment: Alignment.center,
//               duration: const Duration(
//                 milliseconds: 800,
//               ),
//             ),
//           );
//         }
//         if (state is AppPostCleanerErorrtate) {
//           Fluttertoast.showToast(
//               msg: "You Enter Invalid data",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.TOP,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0);
//         }
//       },
//       builder: (context, state) {
//         var cubit = AppCubit.get(context);
//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             centerTitle: true,
//             title: Text(
//               'Cleaners',
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     fontSize: 22,
//                   ),
//             ),
//             elevation: 0,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => PaymentScreen(),
//                 ));
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Order Data ',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 17,
//                           ),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           PageTransition(
//                             child: CleanerScreen(),
//                             type: PageTransitionType.fade,
//                             alignment: Alignment.center,
//                             duration: const Duration(
//                               milliseconds: 800,
//                             ),
//                           ),
//                         );
//                       },
//                       icon: const Icon(
//                         IconBroken.Edit,
//                         color: Color(0xff686874),
//                         size: 26,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Stack(
//                   // alignment: AlignmentDirectional.center,
//                   children: [
//                     Card(
//                       elevation: 10,
//                       child: Container(
//                         height: 130,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white30,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             //crossAxisAlignment: CrossAxisAlignment.baseline,
//                             //  textBaseline: TextBaseline.alphabetic,
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/svg/company.svg',
//                                 color: const Color(0xff686874),
//                                 height: 25,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 cubit.placeValueCleaner == '1'
//                                     ? 'Company'
//                                     : 'Home',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                       fontSize: 14,
//                                     ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               const Icon(
//                                 IconBroken.Location,
//                                 color: Color(0xff686874),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'x4xs',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                       fontSize: 14,
//                                     ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               const Icon(
//                                 IconBroken.Document,
//                                 color: Color(0xff686874),
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'Monthly',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                       fontSize: 14,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 Container(
//                   height: 0.5,
//                   width: double.infinity,
//                   color: Colors.black,
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Text(
//                       'Total',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 16,
//                           ),
//                     ),
//                     const Spacer(),
//                     Text(
//                       ' EGP/ Month',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 17,
//                             color: deafaultColor,
//                           ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 267),
//                 ConditionalBuilderRec(
//                   condition: state is! AppPostCleanerLoadingState,
//                   builder: (context) => deafaultButton(
//                     buttonColor: deafaultColor!,
//                     buttonText: 'Send Requset',
//                     onPressed: () {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //   builder: (context) => const DoneOrderSCreen(),
//                       // ));

//                       // cubit.postCleaner(
//                       //   plcae: cubit.placeCleaner,
//                       //   location: cubit.loctionCleaner,
//                       //   lat: cubit.latCleaner,
//                       //   lng: cubit.lngCleaner,
//                       //   ordertype: cubit.ordertypeCleaner,
//                       //   total: cubit.totalCleaner,
//                       //   card_number: cubit.cardnumberCleaner,
//                       //   expire_date: cubit.expiredateCleaner,
//                       //   cvv: cubit.cvvCleaner,
//                       //   holder_name: cubit.holdernameCleaner,
//                       // );
//                       // print(cubit.placeCleaner);
//                       // print(cubit.loctionCleaner);
//                       // print(cubit.latCleaner);
//                       // print(cubit.lngCleaner);
//                       // print(cubit.ordertypeCleaner);
//                       // print(cubit.totalCleaner);
//                       // print(cubit.cardnumberCleaner);
//                       // print(cubit.expiredateCleaner);
//                       // print(cubit.cvvCleaner);
//                       // print(cubit.holdernameCleaner);
//                     },
//                     context: context,
//                   ),
//                   fallback: (context) =>
//                       const Center(child: CircularProgressIndicator()),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
