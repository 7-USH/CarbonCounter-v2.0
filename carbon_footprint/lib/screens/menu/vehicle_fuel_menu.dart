// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

import 'package:carbon_footprint/constants/themes.dart';

class VehicleFuelMenu extends StatefulWidget {
  VehicleFuelMenu({Key? key}) : super(key: key);
  static String id = "VehicleFuelMenu";

  @override
  State<VehicleFuelMenu> createState() => _VehicleFuelMenuState();
}

class _VehicleFuelMenuState extends State<VehicleFuelMenu> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.pop(
                    context,
                    (currentIndex == -1)
                        ? "Fuel Type"
                        : CheckBoxModel.options[currentIndex].title);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: kTextColor,
              ),
            ),
            elevation: 0,
            title: Text(
              "Back to journey details",
              textScaleFactor: 0.7,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 16),
                child: Text(
                  "Fuel type",
                  textScaleFactor: 1.3,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 16, right: 32),
                child: Text(
                  "What type of fuel is used by your vehicle?",
                  textScaleFactor: 0.5,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 32.0, left: 16, right: 32),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: ListTile(
                            title: Text(
                              CheckBoxModel.options[index].title,
                              textScaleFactor: 1.5,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            leading: Image.asset(
                              CheckBoxModel.options[index].image,
                            ),
                            trailing: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                activeColor: kSecondaryColor,
                                checkColor: Colors.white,
                                value: (currentIndex == index) ? true : false,
                                onChanged: (value) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: CheckBoxModel.options.length,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBoxModel {
  String image;
  String title;
  String? subtitle;
  CheckBoxModel({
    required this.image,
    required this.title,
    this.subtitle,
  });
// var options = ["Petrol", "Diesel", "Biodiesel", "CNG", "Electricity", "LPG"];
  static List<CheckBoxModel> options = [
    CheckBoxModel(
      image: "assets/images/icons/Petrol.png",
      title: "Petrol",
    ),
    CheckBoxModel(
      image: "assets/images/icons/Diesel.png",
      title: "Diesel",
    ),
    CheckBoxModel(
      image: "assets/images/icons/Biodiesel.png",
      title: "Biodiesel",
    ),
    CheckBoxModel(
      image: "assets/images/icons/CNG.png",
      title: "CNG",
    ),
    CheckBoxModel(
      image: "assets/images/icons/Electric.png",
      title: "Electricity",
    ),
    CheckBoxModel(
      image: "assets/images/icons/LPG.png",
      title: "LPG",
    ),
  ];
}
