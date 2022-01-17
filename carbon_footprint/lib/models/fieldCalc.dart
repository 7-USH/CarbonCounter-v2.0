class CarbonCalculator{
  var petrol_lit = 2.33;
  var diesel_lit = 2.68;
  var car_cng_kg = 3.06;
  var taxis_km = 0.30584;
  var localbus_km = 0.053596;
  var auto_km = 0.05;
  var localtrain_km = 0.10;
  var lpg_unit = 42.50;
  var electricity_KWH = 0.90;

  static double  cal_car_petrol_mil(double mileage, double distance) {
    return (2.33 * (distance / mileage));
  }

  static double cal_car_diesel_mileage(double mileage, double distance) {
    return (2.68 * (distance / mileage));
  }

  static double cal_car_cng(var cng_mileage, var dist) {
    return ((3.06/0.636) * (dist / cng_mileage));
  }

  double cal_taxis(var dist) {
    return (taxis_km * dist);
  }

  double cal_localbus(var dist) {
    return (localbus_km * dist);
  }

  double cal_localtrain(var dist) {
    return (localtrain_km * dist);
  }

  double cal_auto(var dist) {
    return (auto_km * dist);
  }

  double cal_LPG(var no) {
    return (lpg_unit * no);
  }

  double cal_electricity(var unit) {
    return (electricity_KWH * unit);
  }
  
}