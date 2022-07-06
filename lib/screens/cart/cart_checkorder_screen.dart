import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/screens/cart/cart_screen.dart';
import 'package:green_bin/screens/cleaner/google.dart';
import 'package:green_bin/screens/done_order_screen.dart';
import 'package:green_bin/screens/exchange_products/exchange_products_screen.dart';
import 'package:page_transition/page_transition.dart';

class CartCheckOrderScreen extends StatefulWidget {
  const CartCheckOrderScreen({Key? key}) : super(key: key);

  @override
  State<CartCheckOrderScreen> createState() => _CartCheckOrderScreenState();
}

class _CartCheckOrderScreenState extends State<CartCheckOrderScreen> {
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        locationController.text = AppCubit.get(context).yourlocationSeleted ==
                null
            ? ' Add your location'
            : '${AppCubit.get(context).yourlocationSeleted?.street}  ,${AppCubit.get(context).yourlocationSeleted?.administrativeArea}';

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Perview',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Products',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const ExchangeProductsScreen(),
                              type: PageTransitionType.fade,
                              alignment: Alignment.center,
                              duration: const Duration(
                                milliseconds: 800,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Add product',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 11,
                                    color: deafaultColor,
                                  ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  cubit.cartItems.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          height: 100,
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                builditem(cubit, index),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            itemCount: cubit.cartItems.length,
                            physics: const BouncingScrollPhysics(),
                          ),
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
                  const SizedBox(height: 10),
                  Text(
                    'Location',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: ShadeColor,
                    child: deafualtTextformField(
                        controller: locationController,
                        saved: (saved) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Location must not be empty';
                          }
                          return null;
                        },
                        enableborder: InputBorder.none,
                        obsecure: false,
                        icon: const Icon(
                          IconBroken.Location,
                          size: 26,
                        ),
                        suffixicon: Icon(
                          Icons.my_location,
                          color: deafaultColor,
                          size: 21,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MapScreeen(),
                          ));
                        }),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Order',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'All Items',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                '${cubit.allpoints} point',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Delivery',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                '200 point',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Avilable Point',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                '${cubit.user?.data.data!.user_points}  point',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Required Price',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                              ),
                              const SizedBox(width: 15),
                              FlatButton(
                                onPressed: () {},
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                '${cubit.allpoints! + cubit.delevreypoints} point',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 18,
                                      color: deafaultColor,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //const Spacer(),
                  deafaultButton(
                    buttonColor: deafaultColor!,
                    buttonText: 'Next',
                    onPressed: () {
                      // cubit.postExchangeProduct(
                      //   location: 'mahaala',
                      //   lat: '3.234234',
                      //   lng: '-3.435345',
                      //   allitems: '1400',
                      //   delivery: '200',
                      //   avilablepoints: '1000',
                      //   requierdPay: '20',
                      //   total: '1500',
                      //   productOneId: '1',
                      //   productOneQuantity: '2',
                      //   productOnePoints: '400',
                      //   productTwoId: '2',
                      //   productTwoQuantity: '1',
                      //   productTwoPoints: '200',
                      //   cardNumber: '912345000000008',
                      //   expireDate: '05/25',
                      //   cvv: '101',
                      //   holderName: 'Nour',
                      // );
                      if (cubit.cartItems.isNotEmpty) {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const DoneOrderSCreen(),
                            type: PageTransitionType.fade,
                            alignment: Alignment.center,
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg:
                              "Your Cart Still Empty, Please add some products ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    context: context,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget builditem(AppCubit cubit, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          //  vertical: 2,
        ),
        child: Row(
          children: [
            Text(
              '${cubit.cartItems[index].quantity}',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 17,
                    color: deafaultColor,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              '${cubit.cartItems[index].name}',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                  ),
            ),
            const Spacer(),
            Text(
              '${cubit.cartItems[index].points}  Point',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      );
}
