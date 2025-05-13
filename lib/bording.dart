import 'package:flutter/material.dart';
import './auth/login.dart';
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/blind.jpg",
      "title": "Navigate with your",
      "highlight": "voice",
      "description":
      "Use voice commands to move confidently through your surroundings with real-time audio feedback and directions.",
    },
    {
      "image": "assets/images/scan.jpg",
      "title": "See the world through",
      "highlight": "sound",
      "description":
      "VocalEye identifies objects and people around you and describes them out loud, making daily life more accessible.",
    },
    {
      "image": "assets/images/sos.jpg",
      "title": "Instant support when you need",
      "highlight": "help",
      "description":
      "With one tap or voice command, connect to your trusted contacts or emergency services quickly and easily.",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // PageView for Swiping
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]["image"]!,
                title: onboardingData[index]["title"]!,
                highlight: onboardingData[index]["highlight"]!,
                description: onboardingData[index]["description"]!,
              ),
            ),
          ),

          // Dot Indicator & Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => buildDot(index == currentPage),
                  ),
                ),
                SizedBox(height: 20),

                // Next or Get Started Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to SignIn
                        );                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0068CB),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isActive ? 18 : 6,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF0068CB) : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// Onboarding Content Widget
class OnboardingContent extends StatelessWidget {
  final String image, title, highlight, description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.highlight,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Section
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade400, // Border color
              width: 2.0,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            child: Image.asset(
              image,
              // fit: BoxFit.contain,
              // height: 150,
              // width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),


        // Text Content
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: title, // Title text
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: " $highlight", // Add space before highlighted text
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xFF0068CB)),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
