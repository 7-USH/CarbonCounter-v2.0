// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:carbon_footprint/constants/themes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class VehicleSizeMenu extends StatefulWidget {
  VehicleSizeMenu({Key? key}) : super(key: key);
  static String id = "VehicleSizeMenu";

  @override
  State<VehicleSizeMenu> createState() => _VehicleSizeMenuState();
}

class _VehicleSizeMenuState extends State<VehicleSizeMenu> {
  int activeIndex = 0;
  bool confirmed = false;

  var optionList = {
    "image": [
      "https://stimg.cardekho.com/images/carexteriorimages/630x420/Maruti/Swift/8378/1614747593719/front-left-side-47.jpg?impolicy=resize&imwidth=420",
      "https://s7d1.scene7.com/is/image/hyundai/category-page-sonata-hybrid-01-1:4-3?qlt=85,0",
      "https://images.unsplash.com/photo-1612057473166-af2affdb92ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3V2fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    ],
    "title": [
      "Hatch back",
      "Sedan",
      "SUV",
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [kPrimeColor, kGreenOne, kGreenTwo])),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context, optionList["title"]![activeIndex]);
              },
              icon: Icon(
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
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 100,
                      bottom: MediaQuery.of(context).size.height / 40,
                      left: MediaQuery.of(context).size.width / 15,
                      right: MediaQuery.of(context).size.width / 15,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  "Vehicle type",
                                  textScaleFactor: 1.5,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "What type of car are you travelling in today?",
                                  textScaleFactor: 0.5,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 15,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: optionList["image"]!.length,
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2.7,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final image = optionList["image"]![index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: kPrimeColor,
                                    width: (activeIndex == index) ? 10 : 0,
                                  ),                                     
                                ),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          optionList["title"]![activeIndex],
                          textScaleFactor: 2.2,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32,
                            bottom: 16,
                            left: 64,
                            right: 64,
                          ),
                          child: InkWell(
                            onTap: () async {
                              confirmed = true;
                              setState(() {});
                              await Future.delayed(Duration(milliseconds: 200));
                              confirmed = false;
                              setState(() {});
                              Navigator.pop(
                                  context, optionList["title"]![activeIndex]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimeColor.withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.19),
                                    offset: Offset(1, confirmed ? 4 : 8),
                                    blurRadius: 8,
                                  ),
                                  
                                ],
                                
                               borderRadius: BorderRadius.circular(25),
                              ),
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 8),
                                child: Text(
                                  "Confirm Car Type",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
