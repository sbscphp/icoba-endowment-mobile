// import 'dart:convert';
// import 'package:flutter/services.dart';

// class CountryUtils {
//   static late String? _response;
//   static var data;
//   static var countries;
//   static late String? selectedCountryCode;

//   static readCountryJson() async {
//     _response = await rootBundle.loadString("assets/json/country_details.json");
//     countries = await json.decode(_response!);
//   }

//   //get list of all the country names in the world
//   static List<String> getWorldCountryNames() => List<String>.from(
//     countries
//         .map((map) => Country.fromJson(map))
//         .map((country) => country.name)
//         .toList(),
//   );

//   //get country list in ascending order(andorra to zimbabwe)
//   // static List<Country> getCountries() => List<Country>.from(countries
//   //     .map((map) => Country.fromJson(map))
//   //     .toList().sort((a, b) => a.name.compareTo(b.name)));

//   static List<Country> getCountries() {
//     List<Country> countryList = List<Country>.from(
//       countries.map((map) => Country.fromJson(map)).toList(),
//     );

//     // Sort the list in place
//     countryList.sort((a, b) => a.name!.compareTo(b.name!));

//     return countryList;
//   }

//   static Country getDefaultCountry({String countryName = 'united kingdom'}) {
//     List<Country> countries = getCountries();

//     //return country by name
//     return countries.firstWhere(
//       (country) => country.name?.toLowerCase() == countryName.toLowerCase(),
//     );
//   }

//   static Country? setSelectedCountry({String? countryCode}) {
//     List<Country> countries = getCountries();

//     int index = countries.indexWhere(
//       (country) => country.dialCode == countryCode,
//     );

//     if (index >= 0) {
//       return countries[index];
//     }
//     return getDefaultCountry();
//   }
// }
