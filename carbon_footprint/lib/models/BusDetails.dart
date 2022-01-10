import 'package:flutter/material.dart';


class BusDetails extends StatelessWidget {
  const BusDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      direction: Axis.vertical,
      children: [
        InkWell(
          splashColor: Colors.grey,
          onTap: () {
            //  TODO: size page
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
                  "Bus Type",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
