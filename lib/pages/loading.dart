import 'package:flutter/material.dart';
import 'package:world_clock/utility/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool loading = true;
  void setupWorldTime() async {
    try {
      DateTimeInfo info = await NetworkRequest.fetchInitialTime();
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: info.toJson(),
      );
    } catch (e) {
      loading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Builder(
        builder: (context) {
          if (loading) {
            return SpinKitFadingFour(
              color: Colors.white,
              size: 100.0,
            );
          } else {
            return TextButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                setupWorldTime();
              },
              child: Text('Retry'),
            );
          }
        },
      ),
    );
  }
}
