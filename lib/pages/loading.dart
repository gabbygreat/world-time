import 'package:flutter/material.dart';
import 'package:world_clock/utility/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance =
        WorldTime(location: 'London', flag: 'uk.JPG', url: 'London');
    await instance.getTime();
   
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location':instance.location,
      'time': instance.time,
      'flag':instance.flag,
      'isDay':instance.isDay,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
    print('this is initstate');
  }

  @override
  Widget build(BuildContext context) {
    print('this is build state');
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child:  SpinKitFadingFour(
            color: Colors.white,
            size: 100.0,
          ),
      ),
    );
  }
}
