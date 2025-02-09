// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

//check internet access for this device
class CheckInternetAccess {

  //creating a loop to check the internet access more than one time
  static Future<bool> createInstanceAndCheckInternetAccess() async {

    bool _hasInternetAccess = false;

    for(int _trail = 0; _trail < 3;_trail++){

      //check internet access
      _hasInternetAccess = await _createInstanceAndCheckInternetAccess();
      
      //if the access is true then break the loop
      if(_hasInternetAccess == true){
        break;
      }
      else if(_hasInternetAccess == false){
        //create delay
        await Future.delayed(const Duration(milliseconds: 100),(){});
        continue;
      }

    }

    return _hasInternetAccess;
  }

  // Create instance & check internet access with parallel URL checks
  static Future<bool> _createInstanceAndCheckInternetAccess() async {
    try {

      // Define the list of internet check options
      final List<InternetCheckOption> _checkOptions = [
        InternetCheckOption(
          timeout: const Duration(seconds: 10),
          uri: Uri.parse('https://google.com'),
          responseStatusFn: (response) =>
          response.statusCode >= 200 && response.statusCode < 300,
        ),
        InternetCheckOption(
          timeout: const Duration(seconds: 10),
          uri: Uri.parse('https://one.one.one.one'),
          responseStatusFn: (response) =>
          response.statusCode >= 200 && response.statusCode < 300,
        ),
      ];

      // Run all URL checks in parallel
      final _results = await Future.wait(
        _checkOptions.map((option) async {
          final connectionInstance = InternetConnection.createInstance(
            customCheckOptions: [option],
          );
          return await connectionInstance.hasInternetAccess;
        }),
      );

      // Check if any result is true
      final bool _hasAccess = _results.any((result) => result == true);

      return _hasAccess;

    } catch (e) {

      return false; // Return false in case of an error

    }
  }

}
