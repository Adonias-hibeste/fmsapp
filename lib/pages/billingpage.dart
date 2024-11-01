import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BillingPage extends StatefulWidget {
  final double totalAmount; // Accepting total amount as parameter

  BillingPage({required this.totalAmount});

  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for each field
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController woredaController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();

  String paymentUrl = '';
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setupWebView();
  }

  Future<void> initiatePayment() async {
    // Fetching userId from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.98.97/api/user/membershipPayment/process'), // Correct route
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'user_id': userId.toString(),
          'amount': widget.totalAmount.toString(),
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'city': cityController.text,
          'woreda': woredaController.text,
          'house_no': houseNoController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          setState(() {
            paymentUrl = responseData['data']['checkout_url'];
            isLoading = false;
            _controller.loadRequest(Uri.parse(paymentUrl));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        final error = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $error')));
      }
    } catch (e) {
      print('Payment initiation failed: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Payment initiation failed.')));
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
        backgroundColor: Colors.green.shade700,
        title: Text(
          "Billing Payment",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Name Field
                _buildTextField(nameController, 'Name'),
                SizedBox(height: 16),
                // Email Field
                _buildTextField(emailController, 'Email'),
                SizedBox(height: 16),
                // Phone Number Field
                _buildTextField(phoneController, 'Phone Number'),
                SizedBox(height: 16),
                // City Field
                _buildTextField(cityController, 'City'),
                SizedBox(height: 16),
                // Woreda Field
                _buildTextField(woredaController, 'Woreda'),
                SizedBox(height: 16),
                // House Number Field
                _buildTextField(houseNoController, 'House No.'),
                SizedBox(height: 16),
                // Display Total Amount
                Text(
                  'Total Amount: \$${widget.totalAmount}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                // Pay Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      initiatePayment(); // Call the function to initiate payment
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Center(
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // WebView for Payment
                if (!isLoading && paymentUrl.isNotEmpty)
                  Container(
                    height: 400,
                    child: WebViewWidget(controller: _controller),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build a reusable text field
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
