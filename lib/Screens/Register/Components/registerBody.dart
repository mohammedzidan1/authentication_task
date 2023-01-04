import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/buttons.dart';
import '../../../../constants.dart';
import '../../HomePage.dart';
import '../../Login/login.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool emptyArea = false;

    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50).r,
                child: SizedBox(
                  width: 260.w,
                  child: Column(
                    children: [
                      Text(
                        "Register Now!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFontSize.sp,
                          fontWeight: mainFontWeight,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Create an Account,Its free",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: commonTextSize.sp,
                          color: lightGreyReceiptBG,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////////////////

              SizedBox(width: double.infinity.w, height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0).r,
                      child: SizedBox(
                        width: 220.w,
                        height: 90.h,
                        child: TextFormField(
                          controller: _userNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              displaySnackBar("enter your email");
                              emptyArea = true;
                              return "empty";
                            }
                            return null;
                          },
                          cursorColor: textBlack,
                          style: TextStyle(fontSize: subFontSize.sp),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            icon: const Icon(
                              Icons.person,
                              color: textBlack,
                            ),
                            labelText: "User Name",
                            hintText: "Ahmed Mohamed",
                            labelStyle: TextStyle(
                                color: textBlack,
                                fontSize: mainFontSize.sp,
                                fontWeight: mainFontWeight),
                            hintStyle: TextStyle(
                                color: textBlack, fontSize: subFontSize.sp),
                          ),
                          onChanged: (text) {
                            // TODO: add your code to add User Name in firestore
                          },
                        ),
                      ),
                    ),
///////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0).r,
                      child: SizedBox(
                        width: 220.w,
                        height: 90.h,
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              displaySnackBar("enter your email");
                              emptyArea = true;
                              return "empty";
                            }
                            return null;
                          },
                          cursorColor: textBlack,
                          style: TextStyle(fontSize: subFontSize.sp),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            icon: const Icon(
                              Icons.email_outlined,
                              color: textBlack,
                            ),
                            labelText: "Email",
                            hintText: "abc@gmail.com",
                            labelStyle: TextStyle(
                                color: textBlack,
                                fontSize: mainFontSize.sp,
                                fontWeight: mainFontWeight),
                            hintStyle: TextStyle(
                                color: textBlack, fontSize: subFontSize.sp),
                          ),
                          onChanged: (text) {
                            // TODO: add your code to add the user email in firestore
                          },
                        ),
                      ),
                    ),
///////////////////////////////////////////////////////////////////////////////////

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0).r,
                      child: SizedBox(
                        width: 220.w,
                        height: 90.h,
                        child: TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              displaySnackBar("enter your email");
                              emptyArea = true;
                              return "empty";
                            }
                            return null;
                          },
                          cursorColor: textBlack,
                          style: TextStyle(fontSize: subFontSize.sp),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            icon: const Icon(
                              Icons.password_outlined,
                              color: textBlack,
                            ),
                            labelText: "Password",
                            hintText: "******",
                            labelStyle: TextStyle(
                                color: textBlack,
                                fontSize: mainFontSize.sp,
                                fontWeight: mainFontWeight),
                            hintStyle: TextStyle(
                                color: textBlack, fontSize: subFontSize.sp),
                          ),
                          onChanged: (text) {
                            // TODO: add your code to add the user password in firestore
                          },
                        ),
                      ),
                    ),
///////////////////////////////////////////////////////////////////////////////////
                    SizedBox(height: 30.h, width: double.infinity.w),
                    DefaultButton(
                        text: "Register",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            emptyArea = false;
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            _auth.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text)
                                .then((
                                value)
                            =>
                                FirebaseFirestore.instance.collection('Users')
                                    .doc(value.user!.uid)
                                    .set({
                                  'userName': _userNameController.text,
                                  'email':_emailController.text,
                                  'password':_passwordController.text,
                                })
                            ).catchError((e) {
                              debugPrint('e $e');
                            }
                            );
                          }
                          if (emptyArea == false) {
                            await displaySnackBar("loading");

                            // Navigator.pushNamed(context, HomePage.routeName);
                            print(_passwordController.text);
                            print(_emailController.text);
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            _auth.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text).then((
                                value) {
                                FirebaseFirestore.instance.collection('Users')
                                    .doc(value.user!.uid)
                                    .set({
                                  'userName': _userNameController.text,
                                  'email':_emailController.text,
                                  'password':_passwordController.text,
                                });
                                Navigator.pushNamed(context, HomePage.routeName);
                                }
                            ).catchError((e) {
                              debugPrint('e $e');
                            });

                          }
                        }),
///////////////////////////////////////////////////////////////////////////////////
                    SizedBox(height: 20.h, width: double.infinity.w),
                    Text(
                      "Already have an account ?",
                      style: (TextStyle(
                          color: textBlack, fontSize: commonTextSize.sp)),
                    ),
///////////////////////////////////////////////////////////////////////////////////
                    InkWell(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            color: textBlack,
                            fontSize: commonTextSize.sp,
                            fontWeight: commonTextWeight),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Login.routeName);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
