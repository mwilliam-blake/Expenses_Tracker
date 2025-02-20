import 'package:flutter/material.dart';
import 'expenses.dart';
import 'onboarding/login/login.dart';


class MyHomePages extends StatefulWidget {


  @override
  State<MyHomePages> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 50,),
              // First Image (U2.png)
              Image.asset(
                "lib/domain/app/assets/images/icon.png",
                height: 40,
                width: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 70),
              // Stack for overlapping images and text
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Box Image (U6.png - Grey Rectangle)
                  Image.asset(
                    "lib/domain/app/assets/images/bg.png",
                    width: 350,
                    height: 500,
                    fit: BoxFit.contain,
                  ),
                  // Overlapping Image (UI1.png)
                  Positioned(
                    top: -60, // Adjust the overlap amount
                    child: Image.asset(
                      "lib/domain/app/assets/images/home.png",
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Text and circles positioned on the overlapping images
                  Positioned(
                    bottom: 70, // Adjust the position relative to U6.png
                    child: Column(
                      children: [
                        const Text(
                          "Easy way to monitor",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Your expense",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Safe Your Future by managing Your",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          "expense right now",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Circles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 4, // Size of the circle
                              backgroundColor: Colors.yellow.shade300,
                            ),
                            const SizedBox(width: 5), // Spacing between circles
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Arrow button on the grey rectangle (U6.png)
                  Positioned(
                    bottom: 20, // Adjust vertical position
                    right: 20, // Adjust horizontal position
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Dashboard
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  loginpage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(15), // Rounded rectangle
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Page
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}