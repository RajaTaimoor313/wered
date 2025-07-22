import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside text fields
          FocusScope.of(context).unfocus();
        },
        child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D1B69),
              Color(0xFF6B46C1),
              Color(0xFF8B5CF6),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/background_elements/3_background.png',
                fit: BoxFit.cover,
              ),
            ),
            
            // Top left decorative elements (lanterns)
            Positioned(
              top: 0,
              left: 20,
              child: Image.asset(
                'assets/background_elements/1.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            
            // Bottom mosque silhouette
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/background_elements/2.png',
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            
            // Main content
            SafeArea(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                    ),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                      
                      // Title
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
                      // Subtitle
                      Text(
                        'Join to start your spiritual journey. Track your Khitma, Dhikr and more.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    
                      // Username field
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          autofillHints: const [],
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                              vertical: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
                      // Email field
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          enableSuggestions: true,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                              vertical: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
                      // Password field
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.newPassword],
                          enableSuggestions: true,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                              vertical: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    
                      // Sign Up button
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F1F1F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have account? ',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}