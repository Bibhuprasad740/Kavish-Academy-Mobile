import 'package:flutter/material.dart';
import 'package:kavish_academy/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: GlobalColors.accent3,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                      ),
                      radius: 25,
                    ),
                    const SizedBox(width: 20),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome, ',
                            style: TextStyle(
                              fontSize: 20,
                              color: GlobalColors.accent3,
                            ),
                          ),
                          TextSpan(
                            text: 'Katie!',
                            style: TextStyle(
                              fontSize: 25,
                              color: GlobalColors.accent1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: GlobalColors.accent1.withOpacity(0.5),
                          ),
                          // color: GlobalColors.accent1.withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: GlobalColors.accent1,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
