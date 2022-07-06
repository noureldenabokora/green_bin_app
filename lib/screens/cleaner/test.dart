import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/screens/cleaner/cleaner_checkorder_screen.dart';
import 'package:green_bin/screens/done_order_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

//  Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8.0),
//               height: 1.0,
//               color: Colors.grey.shade400,
//             ),
class _TestScreenState extends State<TestScreen> {
  int curentdata = 0;
  bool completed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 3),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
            SizedBox(width: 4),
            Container(
              height: 2,
              width: 5,
              //    child: Text('data'),
              color: Color(0xffC8C8D5),
            ),
          ],
        ),
      ),
    );
  }
  //  Container(
  //       height: 6,
  //       width: 10,
  //       //    child: Text('data'),
  //       color: Colors.red,
  //     ),

  List<Step> getSteps() => [
        Step(
          isActive: curentdata >= 0,
          state: curentdata > 0 ? StepState.complete : StepState.indexed,
          title: Text('Order Data'),

          content: Container(),
          //       Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Place',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 14,
//                           ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                       ),
//                       child: DropdownButtonFormField(
//                         dropdownColor: Colors.grey.shade100,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade200,
//                             ),
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.api_outlined,
//                             color: Color(0xff686874),
//                           ),
//                         ),
//                         items: cubit.items
//                             .map((e) => DropdownMenuItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ))
//                             .toList(),
//                         hint: const Text('Choose your place'),
//                         onChanged: (String? value) {
//                           cubit.placeValueCleaner = value;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Text(
//                       'Location',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 14,
//                           ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       color: Colors.grey.shade200,
//                       child: deafualtTextformField(
//                         controller: locationCotroller,
//                         saved: (saved) {},
//                         onChange: (value) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'please select your location';
//                           }
//                           return null;
//                         },
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const MapScreeen(),
//                           ));
//                         },
//                         enableborder: InputBorder.none,

//                         // enableborder: OutlineInputBorder(
//                         //   borderSide: BorderSide(
//                         //     width: 50,
//                         //     color: Colors.grey.shade200,
//                         //   ),
//                         //   borderRadius: BorderRadius.circular(7),
//                         // ),
//                         // lable: "Location",
//                         obsecure: false,
//                         icon: const Icon(
//                           IconBroken.Location,
//                           size: 26,
//                         ),
//                         suffixicon: Icon(
//                           Icons.my_location,
//                           color: deafaultColor,
//                           size: 21,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Text(
//                       'order Type',
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                             fontSize: 14,
//                           ),
//                     ),
//                     const SizedBox(height: 13),
//                     Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                       ),
//                       child: DropdownButtonFormField(
//                         dropdownColor: Colors.grey.shade100,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade200,
//                             ),
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade200,
//                             ),
//                             borderRadius: BorderRadius.circular(7),
//                           ),
//                           prefixIcon: const Icon(
//                             IconBroken.Document,
//                             color: Color(0xff686874),
//                           ),
//                         ),
//                         items: cubit.itemmoney
//                             .map((e) => DropdownMenuItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ))
//                             .toList(),
//                         value: cubit.currentValuemoney,
//                         onChanged: (String? value) {
//                           cubit.currentValuemoney = value;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 202),
//                     deafaultButton(
//                       buttonColor: deafaultColor!,
//                       buttonText: 'Next',
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           AppCubit.get(context).saveCleaner1(
//                             location: locationCotroller.text,
//                             place: cubit.placeValueCleaner == 'Company'
//                                 ? '1'
//                                 : '2',
//                             ordertype: '1',
//                             lat: '${UserLocation.lat}',
//                             lon: '${UserLocation.long}',
//                             total: '1500',
//                           );
//                           Navigator.of(context).push(
//                             PageTransition(
//                               child: PaymentScreen(),
//                               type: PageTransitionType.fade,
//                               alignment: Alignment.center,
//                               duration: const Duration(
//                                 milliseconds: 800,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       context: context,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
        ),
        Step(
          isActive: curentdata >= 1,
          state: curentdata > 1 ? StepState.complete : StepState.indexed,
          title: Text(
            'Preview',
            // style: TextStyle(
            //   fontSize: 25,
            // ),
          ),
          content: Container(),
        ),
      ];
}
