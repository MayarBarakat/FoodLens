import 'package:FeedLens/layout/cubit/fitness_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:FeedLens/shared/styles/colors.dart'; // Assuming this is where your color definitions are

class MealsHistoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cubit = FitnessCubit.get(context);
    return BlocConsumer<FitnessCubit, FitnessState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Meals History'),
            backgroundColor: defaultColor,
          ),
          body:cubit.meals.isEmpty?const Center(child: Text('No Meals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: defaultColor),),): ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount:cubit.meals.length,
            itemBuilder: (context, index) {
              final Map<String,dynamic> meal =cubit.meals[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                      child: Lottie.asset(
                        "assets/lottie/meal.json",
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Calories: ${meal['total_calories']} kcal",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Fat: ${meal['total_fat']} g",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Carb: ${meal['total_carb']} g",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Mass: ${meal['total_mass']} g",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Protine: ${meal['total_protine']} g",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
