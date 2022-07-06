import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/cart/cart_checkorder_screen.dart';
import 'package:green_bin/screens/drawer.dart';
import 'package:green_bin/screens/payment_screen.dart';
import 'package:page_transition/page_transition.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            drawer: const DrawerScreen(),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'My Cart',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 23,
                      letterSpacing: 1.2,
                    ),
              ),
              iconTheme: Theme.of(context).iconTheme,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 5,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: cubit.cartItems.isNotEmpty
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildCartItem(context, index, cubit),
                            itemCount: cubit.cartItems.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 2),
                          )
                        : Center(
                            child: Text(
                            'Your Cart Still Empty',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 20,
                                      color: Colors.black45,
                                    ),
                          )),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 1.5,
                    color: Colors.black12,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'All Items',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '${cubit.allpoints} point',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'Delivery',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '200 point',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'Avilable Point',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '${cubit.user?.data.data!.user_points}  point',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Required Price',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                      ),
                      const SizedBox(width: 15),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: PaymentScreen(),
                              type: PageTransitionType.fade,
                              alignment: Alignment.center,
                              duration: const Duration(
                                milliseconds: 800,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Pay',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        color: deafaultColor,
                        minWidth: 10,
                        height: 20,
                      ),
                      const Spacer(),
                      Text(
                        '20 EGP',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              color: deafaultColor,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        ' Total',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '${cubit.allpoints! + cubit.delevreypoints} point',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 18,
                              color: deafaultColor,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  deafaultButton(
                    buttonColor: deafaultColor!,
                    buttonText: 'Next',
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const CartCheckOrderScreen(),
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
        });
  }

  buildCartItem(context, index, AppCubit cubit) => Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  '${cubit.cartItems[index].image}',
                  height: 80,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cubit.cartItems[index].name}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                    Text(
                      'Clean products',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                            color: Colors.black38,
                          ),
                    ),
                    Text(
                      '${cubit.cartItems[index].points}  Point',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                            color: deafaultColor,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: IconButton(
                          onPressed: () {
                            cubit.clearItemFormCart(index);
                          },
                          icon: const Icon(
                            IconBroken.Delete,
                            color: Colors.red,
                            size: 22,
                          )),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            cubit.addcartitem(index);
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                          color: deafaultColor,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${cubit.cartItems[index].quantity}',
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            cubit.miunscartitem(index);
                          },
                          icon: const Icon(
                            Icons.minimize,
                          ),
                          color: Colors.grey,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
