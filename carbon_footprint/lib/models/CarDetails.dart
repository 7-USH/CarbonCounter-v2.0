// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, await_only_futures

import 'package:carbon_footprint/screens/menu/vehicle_fuel_menu.dart';
import 'package:carbon_footprint/screens/menu/vehicle_size_menu.dart';
import 'package:carbon_footprint/screens/provider/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  late String carType;
  late String fuelType;

  Object? name;

  @override
  void initState() {
    super.initState();
    carType = name == null ? "Vehicle Size" : name as String;
    fuelType = name == null ? "Fuel Type" : name as String;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      direction: Axis.vertical,
      children: [
        InkWell(
          splashColor: Colors.grey,
          onTap: () async {
            var type = Navigator.pushNamed(context, VehicleSizeMenu.id);
            var prevType = carType;
            carType = (await type).toString();
            if (carType == "null") {
              carType = prevType;
            }
            Provider.of<DataPage>(context, listen: false).setCarType(carType);
            setState(() {});
          },
          child: Container(
            color: Colors.white24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(1, 4),
                              spreadRadius: 1,
                              blurRadius: 8),
                          BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              offset: const Offset(-3, -4),
                              spreadRadius: -2,
                              blurRadius: 20),
                        ]),
                    child: Icon(
                      Icons.pedal_bike,
                      size: 40,
                    )),
                Text(
                  carType,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () async {
            var type = Navigator.pushNamed(context, VehicleFuelMenu.id);
            var prevType = fuelType;
            fuelType = (await type).toString();
            if (fuelType == "null") {
              fuelType = prevType;
            }
            Provider.of<DataPage>(context, listen: false).setFuelType(fuelType);
            setState(() {});
          },
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(1, 4),
                              spreadRadius: 1,
                              blurRadius: 8),
                          BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              offset: const Offset(-3, -4),
                              spreadRadius: -2,
                              blurRadius: 20),
                        ]),
                    child: Icon(
                      const IconData(0xe905, fontFamily: '2sh'),
                      size: 40,
                    )),
                Text(
                  fuelType,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        )
      ],
    ));
  }
}
