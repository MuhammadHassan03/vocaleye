import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(


        iconTheme: const IconThemeData(color: Colors.black),
        title: Center(
          child: const Text(
            "Navigation",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

          ),
        ),
        backgroundColor: Color(0xFF0068CB),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "wellcome to Navigation screen",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0068CB),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
