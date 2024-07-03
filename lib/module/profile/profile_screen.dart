import 'package:flutter/material.dart';
import 'package:FeedLens/layout/cubit/fitness_cubit.dart'; // Assuming this is where your cubit and user data model are defined
import 'package:flutter_bloc/flutter_bloc.dart'; // For BlocBuilder
import 'package:lottie/lottie.dart';
import '../../../shared/styles/colors.dart'; // Your color definitions

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitnessCubit, FitnessState>(
      builder: (context, state) {
        var cubit = FitnessCubit.get(context);
        var user = cubit.userData; // Assuming userData is an instance of your user data model

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: defaultColor,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset('assets/lottie/profile.json', height: 180),
                ),
                const SizedBox(height: 20),
                _buildProfileDetailCard('First Name', user.user?.firstName ?? 'Not provided'),
                _buildProfileDetailCard('Last Name', user.user?.lastName ?? 'Not provided'),
                _buildProfileDetailCard('Email', user.user?.email ?? 'Not provided'),
                _buildProfileDetailCard('Phone Number', user.user?.phoneNumber ?? 'Not provided'),
                _buildProfileDetailCard('Age', user.user?.age?.toString() ?? 'Not provided'),
                _buildProfileDetailCard('Weight', user.user!.weight.toString() + ' kg' ?? 'Not provided'),
                _buildProfileDetailCard('Height', user.user!.height.toString() + ' cm' ?? 'Not provided'),
                _buildProfileDetailCard('Gender', user.user?.gender ?? 'Not provided'),
                _buildProfileDetailCard('Address', user.user?.address ?? 'Not provided'),
                _buildProfileDetailCard('Needed Calories', user.user!.neededCalories.toString() ?? 'Not calculated yet'),
                const SizedBox(height: 20),
                if (user.user!.neededCalories == null)
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showActivityLevelDialog(context),
                      child: Text('Set Activity Level'),
                      style: ElevatedButton.styleFrom(
                        primary: defaultColor,
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileDetailCard(String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActivityLevelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Activity Level'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildActivityOption(context, 'Sedentary', 'Little or no exercise'),
                _buildActivityOption(context, 'Lightly active', 'Light exercise/sports 1-3 days/week'),
                _buildActivityOption(context, 'Moderately active', 'Moderate exercise/sports 3-5 days/week'),
                _buildActivityOption(context, 'Very active', 'Hard exercise/sports 6-7 days a week'),
                _buildActivityOption(context, 'Super active', 'Very hard exercise/physical job'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildActivityOption(BuildContext context, String title, String description) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // Perform calculation based on selected activity level
        // Update the needed calories and refresh the UI
        if(title == 'Sedentary'){
          title ='sedentary';
        }else if(title == 'Lightly active'){
          title = 'lightly_active';
        }else if(title == 'Moderately active'){
          title = 'moderately_active';
        }else if(title == 'Very active'){
          title = 'very_active';
        }else{
          title = 'super_active';
        }
        _calculateNeededCalories(context, title);
        Navigator.of(context).pop();
      },
    );
  }

  void _calculateNeededCalories(BuildContext context, String activityLevel) {
    var cubit = FitnessCubit.get(context);

    // Update the user data with the new needed calories
    cubit.updateUserNeededCalories(activityLevel,context);

  }
}
