import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shope/view/auth/register_view.dart';
import 'package:shope/view/widget/custom_text.dart';
import 'package:shope/view/widget/custom_text_form_field.dart';
import '../../constance.dart';
import '../../core/view_model/auth_view_model.dart';
import '../../core/view_model/control_view_model.dart';
import '../widget/CustomButton.dart';
import '../widget/CustomText2.dart';
import '../widget/custom_textFormField2.dart';


class LoginScreen extends GetWidget<AuthViewModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: 16, left: 16, top: 126, bottom: 42),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText2(
                                text: 'Welcome,',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(RegisterView());
                                },
                                child: CustomText(
                                  text: 'Sign Up',
                                  fontSize: 18,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: 'Sign in to Continue',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          CustomTextFormField2(
                            title: 'Email',
                            hintText: 'mostafafathy1503@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            validatorFn: (value) {
                              if (value!.isEmpty)
                                return 'Email invalid or not found';
                            },
                            onSavedFn: (value) {
                              controller.email = value;
                            },
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          CustomTextFormField2(
                            title: 'Password',
                            hintText: '***********',
                            obscureText: true,
                            validatorFn: (value) {
                              if (value!.isEmpty)
                                return 'Password is incorrect';
                            },
                            onSavedFn: (value) {
                              controller.password = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            text: 'Forgot Password?',
                            fontSize: 14,
                            alignment: Alignment.centerRight,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            'SIGN IN',
                                () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                controller.signInWithEmailAndPassword();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                CustomText(
                  text: '-OR-',
                  fontSize: 18,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 43,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButtonSocial(
                  title: 'Sign In with Google',
                  image: 'google',
                  onPressedFn: () {
                    controller.signInWithGoogleAccount();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final VoidCallback onPressedFn;
  final String image;
  final String title;

  const CustomButtonSocial({
    required this.onPressedFn,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressedFn,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/google.png',
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
            CustomText(
              text: title,
              fontSize: 14,
            ),
            Container(width: 20),
          ],
        ),
      ),
    );
  }
}