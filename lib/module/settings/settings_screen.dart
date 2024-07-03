import 'package:FeedLens/layout/cubit/fitness_cubit.dart';
import 'package:FeedLens/module/settings/edit_profile/edit_profile.dart';
import 'package:FeedLens/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = FitnessCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body:Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                profilePic(),
                SizedBox(
                  height: 20,
                ),

                profileMenu(context,
                    text: 'Edit Profile', icon: Icons.edit_document,
                    press: () async{
                      navigateTo(context, EditProfileScreen());
                    }
                ),
                profileMenu(context,
                    text: 'Logout', icon: Icons.logout, press: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context)=>AlertDialog(
                            title: Text('Logout Confirmation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            alignment: Alignment.center,
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    cubit.logout(context: context);
                                  },
                                  child: const Text('Logout',style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    color: Colors.red
                                  ),)
                              ),
                              TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();

                                  },
                                  child: const Text('Cancel',style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                  ),)
                              ),
                            ],
                          )
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget profileMenu(context,
      {required String text, required icon, required VoidCallback press}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          primary: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: (Row(
          children: [
            Icon(
              icon,
              size: 32,
              color:  Color(0xff30384c),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    color: defaultColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.grey,),
          ],
        )),
      ),
    );
  }
  Widget profilePic() {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage('assets/images/person.jpg'),
            backgroundColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
