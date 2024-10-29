import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentFormPage extends StatefulWidget {
  @override
  _PaymentFormPageState createState() => _PaymentFormPageState();
}

class _PaymentFormPageState extends State<PaymentFormPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userMembershipController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String paymentUrl = '';
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    setupWebView();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userNameController.text = prefs.getString('userName') ?? 'Unknown';
      userEmailController.text =
          prefs.getString('userEmail') ?? 'unknown@example.com';
      userMembershipController.text =
          prefs.getString('membershipName') ?? 'N/A';
      amountController.text = prefs.getString('membershipPrice') ??
          '0.0'; // Default to 0.0 if not found
    });
  }

  Future<void> initiatePayment() async {
    final prefs = await SharedPreferences.getInstance();
    final userId =
        prefs.getInt('userId'); // Retrieve user_id from shared preferences

    try {
      final response = await http.post(
        Uri.parse('http://192.168.206.97/api/user/membershipPayment/process'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'user_id': userId.toString(), // Pass the user_id as a string
          'amount': amountController.text,
          'name': userNameController.text, // Send the name
          'email': userEmailController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          setState(() {
            paymentUrl = responseData['data']['checkout_url'];
            isLoading = false;
            _controller
                .loadRequest(Uri.parse(paymentUrl)); // Load the payment URL
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        final error = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    } catch (e) {
      print('Payment initiation failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment initiation failed.')),
      );
    }
  }

  void setupWebView() {
    final PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('HTTP error occurred: ${error.response?.statusCode}');
          },
        ),
      );

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Form', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: userNameController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.green.shade700),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade700),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: userMembershipController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Membership',
                    labelStyle: TextStyle(color: Colors.green.shade700),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade700),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.green.shade700),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade700),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: initiatePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                  ),
                  child: Text('Submit Payment',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          if (!isLoading && paymentUrl.isNotEmpty)
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
        ],
      ),
    );
  }
}
