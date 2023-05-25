// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shope/view/widget/CustomButton.dart';
// import 'package:shope/view/widget/custom_text.dart';
// import 'package:shope/view/widget/custom_textFormField2.dart';
//
// import '../core/view_model/selectimage_viewmodel.dart';
// import '../model/profile_view_model.dart';
//
// class EditProfileView extends StatefulWidget {
//   @override
//   _EditProfileViewState createState() => _EditProfileViewState();
// }
//
// class _EditProfileViewState extends State<EditProfileView> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     String _loginMethod =
//         FirebaseAuth.instance.currentUser!.providerData[0].providerId;
//
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 130,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     padding: EdgeInsets.zero,
//                     constraints: BoxConstraints(),
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.black,
//                     ),
//                   ),
//                   CustomText(
//                     text: 'Edit Profile',
//                     fontSize: 20,
//                     alignment: Alignment.bottomCenter,
//                   ),
//                   Container(
//                     width: 24,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           GetBuilder<SelectImageViewModel>(
//             init: SelectImageViewModel(),
//             builder: (controller) => Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding:
//                   EdgeInsets.only(right: 16, left: 16, bottom: 24),
//                   child: Card(
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: _loginMethod == 'google.com' ||
//                           _loginMethod == 'facebook.com'
//                           ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             _loginMethod == 'google.com'
//                                 ? 'assets/images/icons/google.png'
//                                 : 'assets/images/icons/facebook.png',
//                             fit: BoxFit.cover,
//                             height: 40,
//                             width: 40,
//                           ),
//                           SizedBox(
//                             height: 12,
//                           ),
//                           CustomText(
//                             text: _loginMethod == 'google.com'
//                                 ? 'You\'re logged in using Google account!'
//                                 : 'You\'re logged in using Facebook account!',
//                             fontSize: 16,
//                             alignment: Alignment.center,
//                           ),
//                         ],
//                       )
//                           : Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 60,
//                                   backgroundImage: AssetImage(
//                                       'assets/images/profile_pic.png'),
//                                   foregroundImage: controller.imageFile !=
//                                       null
//                                       ? FileImage(controller.imageFile!)
//                                       : null,
//                                 ),
//                                 SizedBox(
//                                   width: 40,
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Get.dialog(
//                                       AlertDialog(
//                                         title: CustomText(
//                                           text: 'Choose option',
//                                           fontSize: 20,
//                                           color: Colors.blue,
//                                         ),
//                                         content: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Divider(
//                                               height: 1,
//                                             ),
//                                             ListTile(
//                                               onTap: () async {
//                                                 try {
//                                                   await controller
//                                                       .cameraImage();
//                                                   Get.back();
//                                                 } catch (error) {
//                                                   Get.back();
//                                                 }
//                                               },
//                                               title: CustomText(
//                                                 text: 'Camera',
//                                               ),
//                                               leading: Icon(
//                                                 Icons.camera,
//                                                 color: Colors.blue,
//                                               ),
//                                             ),
//                                             Divider(
//                                               height: 1,
//                                             ),
//                                             ListTile(
//                                               onTap: () async {
//                                                 try {
//                                                   await controller
//                                                       .galleryImage();
//                                                   Get.back();
//                                                 } catch (error) {
//                                                   Get.back();
//                                                 }
//                                               },
//                                               title: CustomText(
//                                                 text: 'Gallery',
//                                               ),
//                                               leading: Icon(
//                                                 Icons.account_box,
//                                                 color: Colors.blue,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Text('Select Image'),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 38,
//                             ),
//                             CustomTextFormField2(
//                               title: 'Name',
//                               hintText: Get.find<ProfileViewModel>().name.toString(),
//                               initialValue: Get.find<ProfileViewModel>()
//
//                                   .name.toString(),
//                               validatorFn: (value) {
//                                 if (value!.isEmpty || value.length < 4)
//                                   return 'Please enter valid name.';
//                               },
//                               onSavedFn: (value) {
//                                 Get.find<ProfileViewModel>().name = value;
//                               },
//                             ),
//                             SizedBox(
//                               height: 38,
//                             ),
//                             Column(
//                               children: [
//                                 CustomTextFormField2(
//                                   title: 'Email',
//                                   hintText: Get.find<ProfileViewModel>().email.toString(),
//                                   initialValue:
//                                   Get.find<ProfileViewModel>().email.toString(),
//                                   keyboardType:
//                                   TextInputType.emailAddress,
//                                   validatorFn: (value) {
//                                     if (value!.isEmpty)
//                                       return 'Please enter valid email address.';
//                                   },
//                                   onSavedFn: (value) {
//                                     Get.find<ProfileViewModel>().email =
//                                         value;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 38,
//                                 ),
//                                 CustomTextFormField2(
//                                   title: 'Password',
//                                   hintText: '',
//                                   obscureText: true,
//                                   validatorFn: (value) {
//                                     if (value!.isEmpty ||
//                                         value.length < 6)
//                                       return 'Please enter valid password with at least 6 characters.';
//                                   },
//                                   onSavedFn: (value) {
//                                     Get.find<ProfileViewModel>()
//                                         .password = value;
//                                   },
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 50,
//                             ),
//                             _isLoading
//                                 ? CircularProgressIndicator()
//                                 : CustomButton(
//                               'SUBMIT',
//                                   () async {
//                                 if (_formKey.currentState!
//                                     .validate()) {
//                                   setState(() {
//                                     _isLoading = true;
//                                   });
//                                   try {
//                                     await controller
//                                         .uploadImageToFirebase();
//                                     Get.find<ProfileViewModel>()
//                                         .picUrl = controller.picUrl;
//                                   } catch (e) {
//                                     Get.find<ProfileViewModel>()
//                                         .picUrl =
//                                         Get.find<ProfileViewModel>()
//                                             .currentUser!
//                                             .pic;
//                                   }
//                                   _formKey.currentState!.save();
//                                   await Get.find<ProfileViewModel>()
//                                       .updateCurrentUser();
//                                   setState(() {
//                                     _isLoading = false;
//                                   });
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
