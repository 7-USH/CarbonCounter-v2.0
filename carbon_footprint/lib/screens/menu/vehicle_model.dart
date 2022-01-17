class VehicleModel {
  String image;
  String title;
  String? subtitle;
  VehicleModel({
    required this.image,
    required this.title,
    this.subtitle,
  });

  static late String type;

  static List<VehicleModel> carOptions = [
    VehicleModel(
      image:
          "https://stimg.cardekho.com/images/carexteriorimages/630x420/Maruti/Swift/8378/1614747593719/front-left-side-47.jpg?impolicy=resize&imwidth=420",
      title: "Hatch back",
    ),
    VehicleModel(
      image:
          "https://s7d1.scene7.com/is/image/hyundai/category-page-sonata-hybrid-01-1:4-3?qlt=85,0",
      title: "Sedan",
    ),
    VehicleModel(
      image:
          "https://images.unsplash.com/photo-1612057473166-af2affdb92ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3V2fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      title: "SUV",
    ),
  ];

  static List<VehicleModel> busOptions = [
    VehicleModel(
      image: "https://live.staticflickr.com/7345/27935050781_32793c08cf_b.jpg",
      title: "Local bus",
    ),
    VehicleModel(
      image:
          "https://1.bp.blogspot.com/-1OcIAdYJd7k/Xbwg25EireI/AAAAAAAAI3A/kO5zZ0wmNEMmQEwr739Eu7QD2n5BLZ-UgCLcBGAsYHQ/s1600/DSC_9888.jpg",
      title: "Electric bus",
    ),
    VehicleModel(
      image: "https://i.ytimg.com/vi/Ry2tXO4A0kI/maxresdefault.jpg",
      title: "Double-decker bus",
    ),
  ];

  static List<VehicleModel> optionList = carOptions;

  static Future<void> car() async {
    type = "car";
    optionList = carOptions;
  }

  static Future<void> bus() async {
    type = "bus";
    optionList = busOptions;
  }
}
