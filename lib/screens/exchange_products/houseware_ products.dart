import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/cart/cart_screen.dart';
import 'package:green_bin/screens/exchange_products/exchange_products_items.dart';
import 'package:page_transition/page_transition.dart';

class HouseWareProducts extends StatefulWidget {
  const HouseWareProducts({Key? key}) : super(key: key);

  @override
  State<HouseWareProducts> createState() => _HouseWareProductsState();
}

class _HouseWareProductsState extends State<HouseWareProducts> {
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
                      childAspectRatio: 1 / 1.4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) => buildGridItem(
                        cubit, index, context, houseWareProducts, constraints),
                    itemCount: houseWareProducts.length,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                deafaultButton(
                  buttonColor: deafaultColor!,
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const CartScreen(),
                        type: PageTransitionType.fade,
                        alignment: Alignment.center,
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                      ),
                    );
                  },
                  context: context,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGridItem(
    AppCubit cubit,
    index,
    context,
    List<exchangeProduct> products,
    BoxConstraints constraints,
  ) =>
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
                  '${products[index].points} points',
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
                              //  cubit.allCartItemPoints(index);
                              setState(
                                () {
                                  products[index].quantity++;
                                  cubit.cartItems.add(
                                    exchangeProduct(
                                      products[index].name,
                                      products[index].image,
                                      products[index].exchangeProductId,
                                      products[index].points,
                                      products[index].quantity,
                                    ),
                                  );

                                  cubit.allpoints =
                                      cubit.cartItems[index].points;

                                  // print(all);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.plus_one,
                              size: 22,
                              color: deafaultColor,
                            )),
                      ],
                    ),
                    Text(
                      '${products[index].quantity}',
                      // '${cubit.numberofHouseWareProducts}',
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
                                products[index].quantity--;
                                cubit.cartItems.removeLast();
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
