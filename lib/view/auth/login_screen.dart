import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shope/view/auth/register_view.dart';
import 'package:shope/view/widget/custom_text.dart';
import 'package:shope/view/widget/custom_text_form_field.dart';
import '../../constance.dart';
import '../../core/view_model/auth_view_model.dart';
import '../../core/view_model/control_view_model.dart';


class LoginScreen extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Welcome,",
                    fontSize: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(RegisterView());
                    },
                    child: CustomText(
                      text: "Sign Up",
                      color: primaryColor,
                      fontSize: 18,
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
                height: 20,
              ),

              CustomTextFormField(
                onSaved: (value) {
                  controller.email = value!;
                },
                validator: (value) {
                  if (value == null) {
                    return "Please enter your email";
                  }
                  return null;
                },
                labelText: "Email",
                hintText: "Enter your email",
                labelColor: Colors.grey,
                hintColor: primaryColor,
                borderColor: primaryColor,
              ),

              SizedBox(
                height: 15,
              ),

              CustomTextFormField(
                obscureText: true,
                onSaved: (value) {
                  controller.password = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },

                labelText: "Password",
                hintText: '**********',
                labelColor: Colors.grey,
                hintColor: primaryColor,
                borderColor: primaryColor,
              ),

              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Forgot Password?',
                fontSize: 14,
                alignment: Alignment.topRight,
              ),
              SizedBox(
                height: 15,
              ),
          TextButton(
            onPressed: (){
              _formKey.currentState!.save();
              if(_formKey.currentState!.validate()){
                controller.signInWithEmailAndPassword();
              }
            },
            child: CustomText(
              text: "SIGN IN",
              fontSize: 18.0,
              color: Colors.white,
              alignment: Alignment.center,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 140, vertical: 12),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),

              SizedBox(
                height: 10,
              ),
              CustomText(
                text: '-OR-',
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: (MediaQuery.of(context).size.width)*0.6,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: primaryColor,
                    width: 3.0,

                  ),
                ),
                child: TextButton(
                  onPressed: (){
                    controller.googleSignInMethod();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Image.asset(
                        "assets/images/google.png",
                        width: 30.0,
                        height: 30.0,
                      ),

                      const SizedBox(
                        width: 10.0,
                      ),
                      CustomText(
                        text: "Sign In with Google",
                        fontSize: 18.0,
                        color: primaryColor,
                        alignment: Alignment.center,
                      ),
                      _loadbottom(),

                    ],
                  ),
                ),
              ),
          ],

          ),
        ),

      ),

    );
  }
  Widget _loadbottom(){
    return GetBuilder<ControlViewModel>(
        init: ControlViewModel(),
    builder: (controller) => Text(""),
    );
  }
}
