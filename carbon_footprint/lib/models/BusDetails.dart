// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, await_only_futures, file_names

import 'package:carbon_footprint/screens/menu/vehicle_fuel_menu.dart';
import 'package:carbon_footprint/screens/menu/vehicle_model.dart';
import 'package:carbon_footprint/screens/menu/vehicle_size_menu.dart';
import 'package:carbon_footprint/screens/provider/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusDetails extends StatefulWidget {
  const BusDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  late String busType;

  Object? name;

  @override
  void initState() {
    super.initState();
    busType = name == null ? "Bus type" : name as String;
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
            await VehicleModel.bus();
            var type = Navigator.pushNamed(context, VehicleSizeMenu.id);
            var prevType = busType;
            busType = (await type).toString();
            if (busType == "null") {
              busType = prevType;
            }
            Provider.of<DataPage>(context, listen: false).setCarType(busType);
            if(busType == "Electric bus") {
              Provider.of<DataPage>(context, listen: false).setFuelType("Electricity");
            } else {
              Provider.of<DataPage>(context, listen: false).setFuelType("Diesel");
            }
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
                  busType,
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
        
      ],
    ));
  }
}
