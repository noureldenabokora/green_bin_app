import 'package:flutter/material.dart';

Color? deafaultColor = const Color(0xFF00B761);

Color? ShadeColor = const Color(0xffF2F2F5);

//Color? deafaultColor1 = Color(0xff00B761);

Widget deafualtTextformField({
  required TextEditingController controller,
  void Function()? onTap,
  required void Function(String?)? saved,
  void Function(String?)? submitted,
  required String? Function(String?)? validator,
  TextInputType? keybordtype,
  String lable = '',
  Widget? icon,
  Widget? suffixicon,
  required bool obsecure,
  void Function(String)? onChange,
  InputBorder? enableborder,
  String? hittext,
}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChange,

      obscureText: obsecure,
      keyboardType: keybordtype,

      // textAlignVertical: TextAlignVertical.top,
      //textAlign: TextAlign.start,
      style: const TextStyle(
        //   color: Colors.black,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: icon,
        hintText: hittext,
        suffixIcon: suffixicon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        focusColor: Colors.blue,
        fillColor: Colors.blue,
        hoverColor: Colors.blue,
        enabledBorder: enableborder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      onSaved: saved,
      onFieldSubmitted: submitted,
      validator: validator,
    );

Widget deafaultButton({
  required Color buttonColor,
  required String buttonText,
  required void Function()? onPressed,
  context,
}) =>
    FlatButton(
      onPressed: onPressed,
      color: buttonColor,
      textColor: Colors.white,
      minWidth: double.infinity,
      height: 50,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
      ),
    );

Widget buildCheckOrderItem({
  required String title,
  required String moneyForMonth,
  required String time,
  bool? selecetd,
  required BuildContext context,
  var height,
  var sizeheight,
  var moneyheight,
  var moneywidth,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Stack(
        children: [
          Card(
            elevation: 2,
            child: Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    selecetd! ? deafaultColor!.withOpacity(0.2) : Colors.white,
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
                      color: selecetd ? deafaultColor : Colors.grey[400],
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
                padding: const EdgeInsets.all(15.0),
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
                            SizedBox(height: sizeheight),
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  child: Checkbox(
                                    value: true,
                                    //fillColor: deafaultColor!,
                                    onChanged: (s) {},
                                  ),
                                ),
                                Text(
                                  time, //time
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
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
                                        fontSize: 14,
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
                                  child:
                                      Checkbox(value: true, onChanged: (s) {}),
                                ),
                                Text(
                                  '30 Garbage',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 14,
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
                              height: moneyheight,
                              width: moneywidth,
                              decoration: BoxDecoration(
                                color: selecetd
                                    ? deafaultColor
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
                                        fontSize: 15,
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
                                        fontSize: 12,
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
