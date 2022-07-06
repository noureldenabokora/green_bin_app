import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';

import 'package:green_bin/screens/exchange_products/clean_produtcs.dart';
import 'package:green_bin/screens/exchange_products/houseware_%20products.dart';
import 'package:green_bin/screens/home_screen.dart';

class ExchangeProductsScreen extends StatefulWidget {
  const ExchangeProductsScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeProductsScreen> createState() => _ExchangeProductsScreenState();
}

class _ExchangeProductsScreenState extends State<ExchangeProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) => Scaffold(
            backgroundColor: ShadeColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Exchange For Products',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                    ),
              ),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(110.0),
                child: Container(
                  height: 115,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: constraints.maxHeight * 0.0,
                              color: deafaultColor!.withOpacity(0.3),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/svg/coins.svg'),
                                SizedBox(width: constraints.maxWidth * 0.01),
                                Text(
                                  ' Available points:   ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
                                        wordSpacing: 1,
                                        letterSpacing: 1.1,
                                      ),
                                ),
                                Text(
                                  '${cubit.user?.data.data!.user_points}  point',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 15,
                                        color: deafaultColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (() {
                                  cubit.selectCleanProducts();
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cubit.cleanproducts
                                        ? deafaultColor
                                        : ShadeColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/paper.svg',
                                          color: cubit.cleanproducts
                                              ? Colors.white
                                              : const Color(0xff686874),
                                        ),
                                        SizedBox(
                                            width: constraints.maxWidth * 0.01),
                                        Text(
                                          'Clean products',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 13,
                                                color: cubit.cleanproducts
                                                    ? Colors.white
                                                    : const Color(0xff686874),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.01),

                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  cubit.selectHouseware();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cubit.housware
                                        ? deafaultColor
                                        : ShadeColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/houseware.svg',
                                          color: cubit.housware
                                              ? Colors.white
                                              : const Color(0xff686874),
                                        ),
                                        SizedBox(
                                            width: constraints.maxWidth * 0.01),
                                        Text(
                                          'Houseware',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 13,
                                                color: cubit.housware
                                                    ? Colors.white
                                                    : const Color(0xff686874),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       cubit.selectElec();
                            //     },
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         color:
                            //             cubit.elec ? deafaultColor : ShadeColor,
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(10.0),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           children: [
                            //             SvgPicture.asset(
                            //               'assets/svg/screen.svg',
                            //               color: cubit.metals
                            //                   ? Colors.white
                            //                   : const Color(0xff686874),
                            //             ),
                            //             const SizedBox(width: 8),
                            //             Text(
                            //               'Electronics',
                            //               style: Theme.of(context)
                            //                   .textTheme
                            //                   .bodyText2!
                            //                   .copyWith(
                            //                       fontSize: 15,
                            //                       color: cubit.elec
                            //                           ? Colors.white
                            //                           : const Color(0xff686874)),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Builder(
              builder: (context) {
                if (state
                    is AppInitailbottomtabBarExchangeProductsSucsessState) {
                  return const CleanProducts();
                }

                if (state is ChangeBottomTabBaExchangeProductsState) {
                  if (state.cleanProducts == true) {
                    return const CleanProducts();
                  } else if (state.houseWare == true) {
                    return const HouseWareProducts();
                  }
                }
                return const CleanProducts();
              },
            ),
          ),
        );
      },
    );
  }
}


// class ExchangeProductsScreen extends StatelessWidget {
//   ExchangeProductsScreen({Key? key}) : super(key: key);
//   int number = 0;

//   @override
//   Widget build(BuildContext context) {
//     var cubit = AppCubit.get(context);

//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Colors.grey.shade200,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             centerTitle: true,
//             title: Text(
//               'Buy Old',
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     fontSize: 22,
//                   ),
//             ),
//             elevation: 0,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => HomeScreen(),
//                 ));
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//               ),
//             ),
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(110.0),
//               child: Container(
//                 height: 115,
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Column(
//                     children: [
//                       Stack(
//                         alignment: AlignmentDirectional.center,
//                         children: [
//                           Container(
//                             width: double.infinity,
//                             height: 50,
//                             color: deafaultColor!.withOpacity(0.3),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset('assets/svg/coins.svg'),
//                               const SizedBox(width: 10),
//                               Text(
//                                 '200',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                       fontSize: 14,
//                                       color: deafaultColor,
//                                     ),
//                               ),
//                               Text(
//                                 ' minimum points =  ',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                       fontSize: 14,
//                                       wordSpacing: 1,
//                                       letterSpacing: 1.1,
//                                     ),
//                               ),
//                               Text(
//                                 '5 EGP',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                       fontSize: 15,
//                                       color: deafaultColor,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: (() {
//                                 cubit.selectPaper();
//                               }),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color:
//                                       cubit.paper ? deafaultColor : ShadeColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Row(
//                                     // crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/svg/paper.svg',
//                                         color: cubit.paper
//                                             ? Colors.white
//                                             : const Color(0xff686874),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         'Paper',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2!
//                                             .copyWith(
//                                               fontSize: 15,
//                                               color: cubit.paper
//                                                   ? Colors.white
//                                                   : const Color(0xff686874),
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 cubit.selectMetals();
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color:
//                                       cubit.metals ? deafaultColor : ShadeColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/svg/metals.svg',
//                                         color: cubit.metals
//                                             ? Colors.white
//                                             : const Color(0xff686874),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         'Metals',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2!
//                                             .copyWith(
//                                               fontSize: 15,
//                                               color: cubit.metals
//                                                   ? Colors.white
//                                                   : const Color(0xff686874),
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 cubit.selectElec();
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color:
//                                       cubit.elec ? deafaultColor : ShadeColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/svg/screen.svg',
//                                         color: cubit.metals
//                                             ? Colors.white
//                                             : const Color(0xff686874),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         'Electronics',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2!
//                                             .copyWith(
//                                                 fontSize: 15,
//                                                 color: cubit.elec
//                                                     ? Colors.white
//                                                     : const Color(0xff686874)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           body: Builder(builder: (context) {
//             if (state is AppInitailbottomtabBarSucsessState) {
//               return const Paper();
//             }

//             if (state is ChangeBottomTabBarBuyOldState) {
//               if (state.elec == true) {
//                 return const Electronics();
//               } else if (state.metal == true) {
//                 return Metal();
//               } else if (state.paper == true) {
//                 return const Paper();
//               }
//             }
//             return const Paper();
//           }),
//         );
//       },
//     );
//   }

//   Widget buildGridItem(index, context) => Stack(
//         children: [
//           Card(
//             elevation: 3,
//             child: Container(
//               height: 220,
//               width: 180,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   5,
//                 ),
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           Container(
//             height: 220,
//             width: 180,
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset('assets/images/persil.jpg'),
//                 const SizedBox(height: 5),
//                 Text(
//                   'News paper',
//                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                         fontSize: 14,
//                         color: Colors.black,
//                       ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   '200 points/ kg',
//                   style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                         fontSize: 14,
//                         color: Colors.greenAccent.shade700,
//                       ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 17.5,
//                           backgroundColor: deafaultColor,
//                           child: const CircleAvatar(
//                             radius: 16,
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               // setState(() {
//                               //   number++;
//                               // });
//                             },
//                             icon: Icon(
//                               Icons.plus_one,
//                               size: 22,
//                               color: deafaultColor,
//                             )),
//                       ],
//                     ),
//                     Text(
//                       '$number',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 16,
//                           ),
//                     ),
//                     Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         const CircleAvatar(
//                           radius: 17.5,
//                           backgroundColor: Colors.grey,
//                           child: CircleAvatar(
//                             radius: 16,
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               // setState(() {
//                               //   number--;
//                               // });
//                             },
//                             icon: const Icon(
//                               Icons.exposure_minus_1_outlined,
//                               size: 22,
//                               color: Colors.grey,
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );

// // BlocConsumer<AppCubit, AppStates>(
// //       listener: (context, state) {},
// //       builder: (context, state) {
// //         var cubit = AppCubit.get(context);
// //         return Scaffold(
// //           backgroundColor: ShadeColor,
// //           appBar: AppBar(
// //             backgroundColor: Colors.white,
// //             centerTitle: true,
// //             title: Text(
// //               'Exchange For Products',
// //               style: Theme.of(context).textTheme.bodyText1!.copyWith(
// //                     fontSize: 18,
// //                   ),
// //             ),
// //             elevation: 0,
// //             leading: IconButton(
// //               onPressed: () {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => HomeScreen(),
// //                 ));
// //               },
// //               icon: const Icon(
// //                 Icons.arrow_back_ios,
// //                 color: Colors.black,
// //               ),
// //             ),
// //             bottom: PreferredSize(
// //               preferredSize: const Size.fromHeight(110.0),
// //               child: Container(
// //                 height: 115,
// //               ),
// //             ),
// //           ),
// //           body: Padding(
// //             padding: const EdgeInsets.all(5.0),
// //             child: Column(
// //               children: [
// //                 Stack(
// //                   alignment: AlignmentDirectional.center,
// //                   children: [
// //                     Container(
// //                       width: double.infinity,
// //                       height: 50,
// //                       color: deafaultColor!.withOpacity(0.3),
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         SvgPicture.asset('assets/svg/coins.svg'),
// //                         const SizedBox(width: 10),
// //                         Text(
// //                           '200',
// //                           style:
// //                               Theme.of(context).textTheme.bodyText2!.copyWith(
// //                                     fontSize: 14,
// //                                     color: deafaultColor,
// //                                   ),
// //                         ),
// //                         Text(
// //                           ' minimum points =  ',
// //                           style:
// //                               Theme.of(context).textTheme.bodyText2!.copyWith(
// //                                     fontSize: 14,
// //                                     wordSpacing: 1,
// //                                     letterSpacing: 1.1,
// //                                   ),
// //                         ),
// //                         Text(
// //                           '5 EGP',
// //                           style:
// //                               Theme.of(context).textTheme.bodyText2!.copyWith(
// //                                     fontSize: 15,
// //                                     color: deafaultColor,
// //                                   ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: GestureDetector(
// //                         onTap: (() {
// //                           cubit.selectPaper();
// //                         }),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: cubit.paper ? deafaultColor : ShadeColor,
// //                             borderRadius: BorderRadius.circular(5),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(10.0),
// //                             child: Row(
// //                               // crossAxisAlignment: CrossAxisAlignment.center,
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 SvgPicture.asset(
// //                                   'assets/svg/paper.svg',
// //                                   color: cubit.paper
// //                                       ? Colors.white
// //                                       : const Color(0xff686874),
// //                                 ),
// //                                 const SizedBox(width: 8),
// //                                 Text(
// //                                   'Paper',
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .bodyText2!
// //                                       .copyWith(
// //                                         fontSize: 15,
// //                                         color: cubit.paper
// //                                             ? Colors.white
// //                                             : const Color(0xff686874),
// //                                       ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 5),
// //                     Expanded(
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           cubit.selectMetals();
// //                         },
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: cubit.metals ? deafaultColor : ShadeColor,
// //                             borderRadius: BorderRadius.circular(5),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(10.0),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 SvgPicture.asset(
// //                                   'assets/svg/metals.svg',
// //                                   color: cubit.metals
// //                                       ? Colors.white
// //                                       : const Color(0xff686874),
// //                                 ),
// //                                 const SizedBox(width: 8),
// //                                 Text(
// //                                   'Metals',
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .bodyText2!
// //                                       .copyWith(
// //                                         fontSize: 15,
// //                                         color: cubit.metals
// //                                             ? Colors.white
// //                                             : const Color(0xff686874),
// //                                       ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 5),
// //                     Expanded(
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           cubit.selectElec();
// //                         },
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: cubit.elec ? deafaultColor : ShadeColor,
// //                             borderRadius: BorderRadius.circular(5),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(10.0),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 SvgPicture.asset(
// //                                   'assets/svg/screen.svg',
// //                                   color: cubit.metals
// //                                       ? Colors.white
// //                                       : const Color(0xff686874),
// //                                 ),
// //                                 const SizedBox(width: 8),
// //                                 Text(
// //                                   'Electronics',
// //                                   style: Theme.of(context)
// //                                       .textTheme
// //                                       .bodyText2!
// //                                       .copyWith(
// //                                           fontSize: 15,
// //                                           color: cubit.elec
// //                                               ? Colors.white
// //                                               : const Color(0xff686874)),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 // Expanded(
// //                 //   child: GridView.builder(
// //                 //     physics: const BouncingScrollPhysics(),
// //                 //     gridDelegate:
// //                 //         const SliverGridDelegateWithFixedCrossAxisCount(
// //                 //       crossAxisCount: 2,
// //                 //       childAspectRatio: 1 / 1.3,
// //                 //       mainAxisSpacing: 2,
// //                 //       crossAxisSpacing: 5,
// //                 //     ),
// //                 //     itemBuilder: (context, index) =>
// //                 //         buildGridItem(index, context),
// //                 //     itemCount: 10,
// //                 //   ),
// //                 // ),

// //                 deafaultButton(
// //                   buttonColor: deafaultColor!,
// //                   buttonText: 'Next',
// //                   onPressed: () {
// //                     // Navigator.of(context).push(MaterialPageRoute(
// //                     //   builder: (context) => const CartScreen(),
// //                     // ));
// //                     Navigator.of(context).push(
// //                       PageTransition(
// //                         child: const CartScreen(),
// //                         type: PageTransitionType.fade,
// //                         alignment: Alignment.center,
// //                         duration: const Duration(
// //                           milliseconds: 800,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   context: context,
// //                 )
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );

// }
