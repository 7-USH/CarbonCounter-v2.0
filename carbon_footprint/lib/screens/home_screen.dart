// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names
import 'package:carbon_footprint/constants/themes.dart';
import 'package:carbon_footprint/models/tiles.dart';
import 'package:carbon_footprint/widgets/bottom_navigation.dart';
import 'package:carbon_footprint/widgets/circular_chart.dart';
import 'package:carbon_footprint/widgets/info_tiles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();

    return Scaffold(
      bottomNavigationBar: MyButtomNavigationBar(),
      body: SafeArea(
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                  height: size.height / 7,
                  width: size.width,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: kPrimeColor,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "assets/2sh.jpg"
                          )
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMd().format(now),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            "Hello, Tushar",
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            // TODO: homepage menu/ drawer
                          },
                          icon: Icon(Icons.menu, color: kTextColor))
                    ],
                  ),
                ),
              ),
              CircularChart(
                // TODO: here enter the Calculated Number
                // and percentage of Co2 Emission as of today
          
                calculationNumber: 10,
                width: size.width / 3,
                height: size.height / 3,
                painter: ProgressPainter(
                    circleWidth: size.width / 10,
                    completedPercentage: 60,
                    defaultCircleColor: kPrimeColor,
                    percentageCompletedCircleColor: kGreenTwo),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "So far this month",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Container(
                  height: size.height / 5,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Utils.getTiles().length,
                      itemBuilder: (BuildContext, index) {
                        return InfoTiles(
                            color: Utils.getTiles()[index].color,
                            icon: Utils.getTiles()[index].icon,
                            text: Utils.getTiles()[index].sentence,
                            percent: Utils.getTiles()[index].emission);
                      })),
              myCustomButton(context)
            ],
          )),
    );
  }
}


Widget myCustomButton(context) {
  return GestureDetector(
    onTap: (){

      //TODO: next page

    },
    child: Container(
      margin: EdgeInsets.only(top:10),
      height: 60,
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
            kPrimeColor,
            kGreenOne
          ] 
        ),
        boxShadow: [
           BoxShadow(
                color: Colors.black.withOpacity(0.19),
                offset: const Offset(0.5, 8),
                spreadRadius: 1,
                blurRadius: 8),
            BoxShadow(
                color: Colors.white.withOpacity(0.4),
                offset: const Offset(-3, -7),
                spreadRadius: -2,
                blurRadius: 20),
        ],
        borderRadius: BorderRadius.circular(25)
      ),
      child: Center(
        child: Text("Reduce Emission",
        style: Theme.of(context).textTheme.subtitle1,).shimmer(
          primaryColor: Colors.white,
          secondaryColor: kPrimeColor,
          duration: const Duration(seconds: 6)
        ),
      ),
    )
  );
}


