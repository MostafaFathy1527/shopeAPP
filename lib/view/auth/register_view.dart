import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shope/view/auth/login_screen.dart';
import '../../constance.dart';
import '../../core/view_model/auth_view_model.dart';
import '../widget/custom_text.dart';
import '../widget/custom_text_form_field.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.off(LoginScreen());
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomText(
                text: "Sign Up,",
                fontSize: 30,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(

                  onSaved: (value) {
                    print(value);
                    _authViewModel.name = value;
                  },
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter your name";
                  }
                },
                labelText: "Name",
                hintText: "Enter your Name",
                labelColor: Colors.grey,
                hintColor: primaryColor,
                borderColor: primaryColor,
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  print(value);
                  _authViewModel.email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                labelText: 'Email',
                hintText: 'Enter your email',
                labelColor: Colors.grey,
                hintColor: primaryColor,
                borderColor: primaryColor,
              ),
              SizedBox(
                height: 40,
              ),
              CustomTextFormField(
                obscureText: true,
                onSaved: (value) {
                  print(value);
                  _authViewModel.password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                labelText: 'Password',
                hintText: 'Enter your password',
                labelColor: Colors.grey,
                hintColor: primaryColor,
                borderColor: primaryColor,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: (MediaQuery.of(context).size.width)*0.3,
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_authViewModel.email);
                      _authViewModel.signUpWithEmailAndPassword();
                    }
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                      const SizedBox(
                        width: 10.0,
                      ),
                      CustomText(
                        text: "Sign Up",
                        fontSize: 18.0,
                        color: primaryColor,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}