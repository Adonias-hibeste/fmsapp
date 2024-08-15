import 'package:flutter/material.dart';
import "package:membermanagementsystem/components/my_textfield.dart";

class Completeregister extends StatefulWidget {
  const Completeregister({super.key});

  @override
  State<Completeregister> createState() => _CompleteregisterState();
}

class _CompleteregisterState extends State<Completeregister> {
  final footballpostion = TextEditingController();
  final teamselection = TextEditingController();
  final skilllevel = TextEditingController();
  final jerseysize = TextEditingController();

  void completeRegisteration() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Image.asset(
                    "lib/images/soccer.png",
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'You are almost done !',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            Text(
              'we need some information to complete your registration',
              style: TextStyle(color: Colors.black, fontSize: 13),
            ),
            SizedBox(
              height: 25,
            ),
            Mytextfield(
              controller: footballpostion,
              hintText: 'Football position',
              obscureText: false,
            ),
            SizedBox(height: 10),
            Mytextfield(
              controller: teamselection,
              hintText: 'Membership level',
              obscureText: false,
            ),
            SizedBox(height: 10),
            Mytextfield(
              controller: skilllevel,
              hintText: 'Skill level',
              obscureText: false,
            ),
            SizedBox(height: 10),
            Mytextfield(
              controller: jerseysize,
              hintText: 'Jersey Size',
              obscureText: false,
            ),
            SizedBox(height: 25),
            GestureDetector(
                onTap: completeRegisteration,
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    "Complete Registeration",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                )),
          ]),
        ),
      ),
    );
  }
}
