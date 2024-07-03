import 'package:FeedLens/layout/cubit/fitness_cubit.dart';
import 'package:FeedLens/module/auth_pages/my_button.dart';
import 'package:FeedLens/shared/components/components.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../shared/styles/colors.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;
  late TextEditingController weightController;
  late TextEditingController heightController;
  late TextEditingController addressController;
  String? selectedGender;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userData = BlocProvider.of<FitnessCubit>(context).userData;

    firstNameController = TextEditingController(text: userData.user!.firstName ?? '');
    lastNameController = TextEditingController(text: userData.user!.lastName ?? '');
    ageController = TextEditingController(text: userData.user!.age.toString() ?? '');
    phoneNumberController = TextEditingController(text: userData.user!.phoneNumber ?? '');
    weightController = TextEditingController(text: userData.user!.weight.toString() ?? '');
    heightController = TextEditingController(text: userData.user!.height.toString() ?? '');
    addressController = TextEditingController(text: userData.user!.address ?? '');
    selectedGender = userData.user!.gender.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FitnessCubit, FitnessState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = FitnessCubit.get(context);

        return BlurryModalProgressHUD(
          inAsyncCall: cubit.userUpdateLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitFadingCircle(
            color: defaultColor,
            size: 90.0,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black.withOpacity(.1),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Icon(Icons.edit, size: 100, color: defaultColor),
                        const SizedBox(height: 30),
                        Text(
                          "Edit your profile.",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        MyTextField(
                          controller: firstNameController,
                          hintText: "First Name",
                          obscureText: false,
                          inputType: TextInputType.text,
                          prefixIcon: Icons.person,

                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: lastNameController,
                          hintText: "Last Name",
                          obscureText: false,
                          inputType: TextInputType.text,
                          prefixIcon: Icons.person_outline,

                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: ageController,
                          hintText: "Age",
                          obscureText: false,
                          inputType: TextInputType.number,
                          prefixIcon: Icons.cake,

                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: phoneNumberController,
                          hintText: "Phone Number",
                          obscureText: false,
                          inputType: TextInputType.phone,
                          prefixIcon: Icons.phone,

                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: weightController,
                          hintText: "Weight",
                          obscureText: false,
                          inputType: TextInputType.number,
                          prefixIcon: Icons.fitness_center,

                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: heightController,
                          hintText: "Height",
                          obscureText: false,
                          inputType: TextInputType.number,
                          prefixIcon: Icons.height,

                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: addressController,
                          hintText: "Address",
                          obscureText: false,
                          inputType: TextInputType.text,
                          prefixIcon: Icons.home,

                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0,),
                          child: DropdownButtonFormField<String>(
                            value: selectedGender,
                            hint: Text("Select Gender", style: TextStyle(color: Colors.grey[700])),
                            items: ['Male', 'Female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(color: defaultColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(color: defaultColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(color: defaultColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: MyButton(
                            onTap: () {
                              cubit.editProfile(
                                context: context,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                age: ageController.text,
                                phoneNumber: phoneNumberController.text,
                                weight: weightController.text,
                                height: heightController.text,
                                address: addressController.text,
                                gender: selectedGender.toString()!,
                              );
                            },
                            text: "Save Changes",
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Powered By AI",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType inputType;
  final IconData? prefixIcon;

  const MyTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.inputType,
    this.prefixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: defaultColor) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: defaultColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: defaultColor,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        ),
      ),
    );
  }
}


