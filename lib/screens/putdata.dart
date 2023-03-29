import 'package:flutter/material.dart';

class PutData extends StatefulWidget {
  const PutData({Key? key}) : super(key: key);

  @override
  State<PutData> createState() => _PutDataState();
}

class _PutDataState extends State<PutData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Gamescores")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: const [
              Text(
                'Enter Gamescores goes here',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
