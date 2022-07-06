import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/trash/trash_checkorder_screen.dart';
import 'package:green_bin/screens/trash/trash_screen.dart';
import 'package:page_transition/page_transition.dart';

class TrashAvialablePlansScreen extends StatelessWidget {
//  const TrashAvialablePlansScreen({Key? key}) : super(key: key);

  bool it = false;
  bool it2 = false;
  bool it3 = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostTrashSucsessState) {
          // Fluttertoast.showToast(
          //   msg: "${state.model.message}",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: deafaultColor,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        }
        if (state is AppPostTrashErorrtate) {
          // Fluttertoast.showToast(
          //   msg: "${state.erorr.message}",
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: deafaultColor,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Trash',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrashScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   it = !it;
                    // });
                  },
                  child: buildItem(
                    'Popular',
                    '30 EGP/',
                    '8 Months',
                    it,
                    context,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   it2 = !it2;
                    // });
                  },
                  child: buildItem(
                    'Special',
                    '20 EGP/',
                    '4 Months',
                    it2,
                    context,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   it3 = !it3;
                    // });
                  },
                  child: buildItem(
                    'Normal',
                    '15 EGP/',
                    '1 Months',
                    it3,
                    context,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ConditionalBuilderRec(
                    condition: state is! AppPostTrashLoadingState,
                    builder: (context) => deafaultButton(
                      buttonColor: deafaultColor!,
                      buttonText: 'Next',
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   PageTransition(
                        //     child: TrashChechOrderScreen(),
                        //     type: PageTransitionType.fade,
                        //     alignment: Alignment.center,
                        //     duration: const Duration(
                        //       milliseconds: 700,
                        //     ),
                        //   ),
                        // );
                      },
                      context: context,
                    ),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(
    String title,
    String moneyForMonth,
    String time,
    bool selecetd,
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Stack(
          children: [
            Card(
              elevation: 2,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: selecetd
                      ? Colors.greenAccent[700]!.withOpacity(0.2)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: selecetd
                            ? Colors.greenAccent[700]
                            : Colors.grey[400],
                      ),
                    ),
                    Text(
                      selecetd ? 'Applied' : 'Apply',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 17,
                            color: selecetd ? Colors.white : Colors.black45,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title, //title
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 17,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    height: 15,
                                    child: Checkbox(
                                      value: true,
                                      onChanged: (s) {},
                                    ),
                                  ),
                                  Text(
                                    time, //time
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 15,
                                          color: selecetd
                                              ? deafaultColor
                                              : Colors.black54,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    child: Checkbox(
                                      value: true,
                                      onChanged: (s) {},
                                    ),
                                  ),
                                  Text(
                                    '5 Days/ Week',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 15,
                                          color: selecetd
                                              ? deafaultColor
                                              : Colors.black54,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    child: Checkbox(
                                        value: true, onChanged: (s) {}),
                                  ),
                                  Text(
                                    '30 Garbage',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 15,
                                          color: selecetd
                                              ? deafaultColor
                                              : Colors.black54,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                height: 60,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: selecetd
                                      ? Colors.greenAccent[700]
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    moneyForMonth, //money for month

                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 17,
                                          color: selecetd
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                  ),
                                  Text(
                                    'month',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 13,
                                          color: selecetd
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
