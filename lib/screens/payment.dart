import 'dart:developer' as dev;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/data.dart';


class PaymentPage extends StatefulWidget {
  final String title = 'Bkash';

  const PaymentPage({Key? key}) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _agreementIdController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Center(
                          child: Image.asset('assets/images/bkash.png'),
                        ),
                        const Text(
                          'Amount :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            hintText: "1240",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2.0),
                            ),
                            // hintText: reviewTitle,
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                        ),
                        const SizedBox(height: 20.0),
                      

                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              backgroundColor: Colors.pink),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await payment_process();
                            /// create an instance of FlutterBkash
                            _showSnackbar("Payment Done");
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> payment_process() async {
    final post =  await FirebaseFirestore.instance.collection("User")
    .where('id', isEqualTo: FirebaseAuth.instance.currentUser?.uid).get()
    .then((QuerySnapshot snapshot) {
          //Here we get the document reference and return to the post variable.
          return snapshot.docs[0].reference;
    });
    num value = profile['money'] as num;
    value = value + int.parse(_amountController.text);
    profile['money'] = value;
    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using post as document reference
    batch.update(post, { 'money': value }); 
    batch.commit();
  }

  /// show snack-bar with message
  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}