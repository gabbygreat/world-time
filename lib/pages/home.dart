import 'package:flutter/material.dart';
import 'package:world_clock/utility/network.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTimeInfo data;
  bool fromInitial = true;

  void onPressed() async {
    final result = await Navigator.pushNamed(
      context,
      '/chooseLocation',
    );
    if (result == null) return;
    data = DateTimeInfo.fromJson(
      Map.from(result as Map<String, dynamic>),
    );
    fromInitial = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final result =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (fromInitial) {
      data = DateTimeInfo.fromJson(result);
    }
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(data.isDay),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_location,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7.0),
                      Text(
                        'Edit Location',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  data.timezone,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  data.time,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
