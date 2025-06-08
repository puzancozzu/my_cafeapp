import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'nav_bar.dart';

class LoginPageUi extends StatefulWidget {
  // const LoginPageUi ({super.key, required this.title});
  // final String title;
  const LoginPageUi ({super.key});

  @override
  State<LoginPageUi> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPageUi> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// ---------------- function to validate password ---------------------------
  String? _PasswordError;
  void _validatePassword(String value) {
    final hasMinLength = value.length >= 8;
    final hasLetter = value.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = value.contains(RegExp(r'\d'));
    final hasSpecialChar = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    setState(() {
      if (value.isEmpty) {
        _PasswordError = 'Password is required';
      } else if (!hasMinLength || !hasLetter || !hasNumber || !hasSpecialChar ){
        _PasswordError = 'Must be at least 8 characters with letters, numbers & special characters';
      } else {
        _PasswordError = null;
      }
    });
  }

  /// -------- function to validate email -------------------------------------
  String? _emailError;
  void _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      if (value.isEmpty) {
        _emailError = 'Email is required';
      } else if (!emailRegex.hasMatch(value)) {
        _emailError = 'Enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final bool isInvalid_pass = _PasswordError != null;
    final bool isInvalid_email = _emailError != null;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title:
        // ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 4,),

                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.98,
                    height: MediaQuery.sizeOf(context).height * 0.04,
                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    //   border: Border.all(width: 1,
                    //     color: Color(0xffA96844),),
                    //   color: Color(0xffA96844),
                    // ),
                    child: Center(
                      child: Text("Login", style: GoogleFonts.karla(
                        textStyle: Theme.of(context).textTheme.displaySmall,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        // fontStyle: FontStyle.italic,
                      ),),
                    ),
                  ),
                  const SizedBox(height: 4,),
        /// -------------------- Logo --------------------------------------------
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        decoration: BoxDecoration(),
                          child: Image.asset(
                            'lib/assets/images/shop_logo.jpg',
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height,
                            fit: BoxFit.fill,
                          ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5,),

            ///---------------------- Container for LOG IN -----------------------
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.98,
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1,
                        color: Color(0xffA96844),),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                /// ------------ Row for Text- Welcome Back! ---------------------
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0,0,0),
                          child: Text("Welcome back!",
                          style: GoogleFonts.karla(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            // fontStyle: FontStyle.italic,
                          ),),
                        ),

                /// -------------- Row for Email/Name ----------------------------
                        const SizedBox(height: 24,),
                        Padding(
                            padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                          child: Text("Email",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                          ),
                        ),

                /// -------------- Row for Email/Name textField ------------------
                        const SizedBox(height: 8,),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.94,
                            child: TextField(
                              controller: emailController,
                              maxLength: 32,
                              onChanged: _validateEmail,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                counter: const SizedBox.shrink(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isInvalid_email? Colors.red: Colors.grey,
                                      width: 1.0
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isInvalid_email? Colors.red : Colors.grey,
                                      width: 1.5
                                  ),
                                ),
                                hintText: 'example@gmail.com',
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // to show if email is not validated
                        if (_emailError != null)
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _emailError!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),


                /// -------------- Row for Password ------------------------------
                        const SizedBox(height: 14,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                          child: Text("Password",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),

                /// --------------- Row for Password Filed ---------------------
                        const SizedBox(height: 8,),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.94,
                            child: TextField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              maxLength: 32,
                              // obscuringCharacter: '*',
                              onChanged: _validatePassword,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                counter: const SizedBox.shrink(),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
                                enabledBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isInvalid_pass? Colors.red : Colors.grey,
                                      width: 1.0
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isInvalid_pass? Colors.red: Colors.grey,
                                      width: 1.5
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Password',
                                hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // to show if password is not validated
                        if (_PasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _PasswordError!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                 /// --------------- Login Button ------------------------------
                        const SizedBox(height: 40,),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.90,
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                print("Login Button Pressed!");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => NavBar()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffA96844), // Button background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: const BorderSide(
                                    color: Color(0xffA96844), // Border color
                                    width: 1,
                                  ),
                                ),
                                elevation: 4,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              child: Text(
                                "Log In",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}