import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/buy_old/buy_old_data_screen.dart';
import 'package:green_bin/screens/buy_old/old_products.dart';
import 'package:page_transition/page_transition.dart';

class Metal extends StatefulWidget {
  @override
  State<Metal> createState() => _MetalState();
}

class _MetalState extends State<Metal> {
  // const Paper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) => buildGridItem(
                      cubit,
                      index,
                      context,
                      metalsoldProducts,
                      constraints,
                    ),
                    itemCount: metalsoldProducts.length,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                deafaultButton(
                  buttonColor: deafaultColor!,
                  buttonText: 'Next',
                  onPressed: () {
                    cubit.savePaperKillos(killos: cubit.numberofPaperKillos);
                    cubit.saveMetalKillos(killos: cubit.numberofMetalsrKillos);

                    cubit.saveElectronicKillos(
                      killos: cubit.numberofElectronicsKillos,
                    );

                    Navigator.of(context).push(
                      PageTransition(
                        child: const BuyOldDataScreen(),
                        type: PageTransitionType.fade,
                        alignment: Alignment.center,
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                      ),
                    );
                  },
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGridItem(AppCubit cubit, index, context,
          List<oldProduct> products, BoxConstraints constraints) =>
      Stack(
        children: [
          Card(
            elevation: 3,
            child: Container(
              height: constraints.maxHeight * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5,
                ),
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  height: constraints.maxHeight * 0.2,
                  image: NetworkImage(
                    '${products[index].image}',
                  ),
                  fit: BoxFit.cover,
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  '${products[index].name}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  '${products[index].points}  points/ kg',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 14,
                        color: deafaultColor,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CircleAvatar(
                          radius: 17.5,
                          backgroundColor: deafaultColor,
                          child: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                products[index].weight++;
                              });
                            },
                            icon: Icon(
                              Icons.plus_one,
                              size: 22,
                              color: deafaultColor,
                            )),
                      ],
                    ),
                    Text(
                      '${products[index].weight}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        const CircleAvatar(
                          radius: 17.5,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                products[index].weight--;
                              });
                            },
                            icon: const Icon(
                              Icons.exposure_minus_1,
                              size: 22,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
