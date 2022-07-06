import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppDeleteNotificationsSucsessState) {
          Fluttertoast.showToast(
            msg: "Notification  Deleted  successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: deafaultColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        // print(cubit.notificationModel.data?.datalist[0].notify_type_id);
        return Scaffold(
          body: SafeArea(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  notifItem(context, cubit.notificationModel, index),
              separatorBuilder: (context, index) => Container(
                height: 2,
                color: const Color(0xffF2F2F5),
              ),
              itemCount: cubit.notificationModel.data!.datalist.length,
            ),
          ),
        );
      },
    );
  }

  Widget notifItem(context, NotificationModel model, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(
            IconBroken.Delete,
            color: Colors.white,
            size: 35,
          ),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.only(right: 10),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          AppCubit.get(context).deleteNotification(
              Id: '${model.data?.datalist[index].notify_id}');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Card(
            margin: const EdgeInsets.all(5),
            elevation: 5,
            child: ListTile(
              leading: Icon(
                IconBroken.Add_User,
                color: deafaultColor,
              ),
              title: Text(
                '${model.data?.datalist[index].notify_title}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
              ),
              subtitle: Text(
                '${model.data?.datalist[index].notify_text}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: const Color(0xff686874),
                      fontSize: 12,
                    ),
              ),
              trailing: Text(
                '${model.data?.datalist[index].notify_custom_date}',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      //color: Colors.black,
                      //    height: 1.2,
                      //  color: Color(0xff686874),
                      fontSize: 8,
                      wordSpacing: 0.1,
                    ),
              ),
            ),
          ),
        ),
      );
}
