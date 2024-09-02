import 'package:flutter/material.dart';

class Paymentsuccess extends StatefulWidget {
  Function()? onTap;
  Paymentsuccess({super.key});

  @override
  State<Paymentsuccess> createState() => _PaymentsuccessState();
}

class _PaymentsuccessState extends State<Paymentsuccess> {
  void returntodashboard() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: Text(
          "Payment Successful",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.check_circle,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            " You've successfully paid your Membership Fee to Addis FC for the season",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(height: 25),
          GestureDetector(
              onTap: returntodashboard,
              child: Container(
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  "view Reciept",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
              )),
        ]),
      ),
    );
  }
}
