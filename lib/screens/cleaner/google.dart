import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_bin/const/const.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/cubit.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/location_model.dart';
import 'package:green_bin/screens/cleaner/cleaner_screen.dart';

class MapScreeen extends StatefulWidget {
  const MapScreeen({Key? key}) : super(key: key);

  @override
  State<MapScreeen> createState() => _MapScreeenState();
}

class _MapScreeenState extends State<MapScreeen> {
  var myMarker = HashSet<Marker>();
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.task_alt_rounded,
                  color: deafaultColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(31.037933, 31.381523),
              zoom: 19,
            ),
            onMapCreated: (GoogleMapController Controller) {
              googleMapController = Controller;
              setState(() {
                myMarker.add(
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(31.037933, 31.381523),
                  ),
                );
              });
            },
            markers: myMarker,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await cubit.locationService().then((value) {
                cubit.getLocation();
              });
              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(UserLocation.lat!, UserLocation.long!),
                      zoom: 14)));

              myMarker.clear();

              myMarker.add(Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: LatLng(
                    UserLocation.lat!,
                    UserLocation.long!,
                  )));
            },
            child: const Icon(
              IconBroken.Location,
              size: 28,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
