import 'dart:io';

import 'package:FeedLens/layout/fitness_layout.dart';
import 'package:FeedLens/model/auth/sign_up_model/sign_up_model.dart';
import 'package:FeedLens/model/get_user_data/user_data.dart';
import 'package:FeedLens/model/image_scan_model/scan_image_model.dart';
import 'package:FeedLens/model/user_update/user_update_model.dart';
import 'package:FeedLens/module/auth_pages/login/login_screen.dart';
import 'package:FeedLens/module/daily_meals/daily_meals_screen.dart';
import 'package:FeedLens/module/profile/profile_screen.dart';
import 'package:FeedLens/module/settings/settings_screen.dart';
import 'package:FeedLens/module/track/meals_screen.dart';
import 'package:FeedLens/shared/components/components.dart';
import 'package:FeedLens/shared/network/end_points.dart';
import 'package:FeedLens/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/auth/login_model/login_model.dart';
import '../../model/add_image_model/image_model.dart';
import '../../model/goals_model/goals_model.dart';
import '../../shared/network/local/cache_helper.dart';

part 'fitness_state.dart';

class FitnessCubit extends Cubit<FitnessState> {
  FitnessCubit() : super(FitnessInitial());
  static FitnessCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    DailyMealsScreen(),
    MealsHistoryScreen(),
    ProfileScreen(),
    const SettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(FitnessChangeBottomState());
  }

  late LoginModel loginModel;
  bool loginLoading = false;
  Future<void>login({
    required BuildContext context,
    required String email,
    required String password,
}) async{
    loginLoading = true;
    emit(FitnessLoginLoadingState());
    DioHelper.postData(url: LOG_IN, data: {
      'email':email,
      'password':password
    }).then((value)async {
      var testResponse = value.data;
      if (testResponse['status']== false){
        loginLoading = false;
        showToast(text: "Username or Password  is not correct", state: ToastStates.ERROR);
        emit(FitnessLoginNotAuthState());
      }else{
        loginModel = LoginModel.fromJson(value.data);
        CacheHelper.saveData(key: 'token', value: loginModel.data!.token);
        CacheHelper.saveData(key: 'isLoggedIn', value: true);
        loginLoading = false;
        await getUserData(token: CacheHelper.getData(key: 'token'));
        currentIndex = 0;
        emit(FitnessLoginSuccessfullyState());
        navigateAndFinish(context, FitnessLayout());
      }
    }).onError((error, stackTrace) {
      loginLoading = false;
      print(error.toString());
      showToast(text: "Error...", state: ToastStates.ERROR);

      emit(FitnessLoginErrorState());
    });
  }

  late SignUpModel signUpModel;
  bool signUpLoading = false;
  Future<void> signup({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String age,
    required String phoneNumber,
    required String weight,
    required String height,
    required String address,
    required String gender,
})async {
    signUpLoading = true;
    emit(FitnessSignUpLoadingState());
    DioHelper.postData(url: SIGN_UP, data: {
      'first_name':firstName,
      'last_name':lastName,
      'email':email,
      'password':password,
      'age':age,
      'phone_number':phoneNumber,
      'weight':weight,
      'height':height,
      'address':address,
      'gender':gender,
    }).then((value)async{
      signUpModel = SignUpModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: signUpModel.accessToken);
      CacheHelper.saveData(key: 'isLoggedIn', value: true);
      signUpLoading = false;
      await getUserData(token: CacheHelper.getData(key: 'token'));
      currentIndex = 0;
      navigateAndFinish(context, FitnessLayout());
      emit(FitnessSignUpSuccessfullyState());
    }).onError((error, stackTrace) {
      signUpLoading = false;
      showToast(text: 'Register Error...', state: ToastStates.ERROR);
      print(error.toString());
      emit(FitnessSignUpErrorState());
    });
}

  late UserData userData;
  bool noInternet = false;
  bool userDataLoading= false;
  Future<void> getUserData({required String token})async{
    userDataLoading = true;
    noInternet = false;
    emit(FitnessUserDataLoadingState());
    DioHelper.getData(url: USER_DATA,token: token).then((value)async {
      userData= UserData.fromJson(value.data);
     await getGoals();
      await getMealsHistory();
      userDataLoading = false;
      noInternet = false;
      emit(FitnessUserDataSuccessfullyState());
    }).onError((error, stackTrace) {
      userDataLoading = false;
      noInternet = true;
      print(error.toString());
      emit(FitnessUserDataErrorState());
    });
  }

  late UserUpdatedModel userUpdatedModel;
  bool userUpdateLoading = false;
  Future<void> editProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String age,
    required String phoneNumber,
    required String weight,
    required String height,
    required String address,
    required String gender,
})async{
    userUpdateLoading = true;
    emit(FitnessUserUpdateLoadingState());
    await DioHelper.postData(url: USER_UPDATE, data: {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'address': address,
    }).then((value)async {
       userData =  UserData.fromJson(value.data);
      userUpdateLoading = false;
      Navigator.of(context).pop();
      showToast(text: 'The user information has been updated', state: ToastStates.SUCCESS);
      emit(FitnessUserUpdateSuccessfullyState());
    }).onError((error, stackTrace) {
      userUpdateLoading = false;
      print(error.toString());
      showToast(text: 'The user information not updated', state: ToastStates.ERROR);
      emit(FitnessUserUpdateErrorState());
    });
  }

  Future<void> logout({
    required BuildContext context,
})async{
    DioHelper.postData(url: LOGOUT, data: {}).then((value) {
      var checkLogout = value.data['message'];
      if(checkLogout == 'Successfully logged out'){
        showToast(text: 'Logout successfully', state: ToastStates.SUCCESS);
        CacheHelper.removeData(key: 'token');
        CacheHelper.removeData(key: 'isLoggedIn');
        navigateAndFinish(context, LoginScreen());
        emit(FitnessLogoutSuccessfullyState());
      }
      else{
        showToast(text: 'Logout Failed', state: ToastStates.ERROR);
        Navigator.of(context).pop();
        emit(FitnessLogoutErrorState());
      }
    }).onError((error, stackTrace) {
      showToast(text: 'Logout Failed', state: ToastStates.ERROR);
      print(error.toString());
      Navigator.of(context).pop();
      emit(FitnessLogoutErrorState());
    });

}
  bool loadingTDEE = false;
  void updateUserNeededCalories(String activityLevel,BuildContext context) {
    loadingTDEE = true;
    emit(FitnessUpdateNeededCaloriesLoadingState());
    DioHelper.postData(url: CALCULIAT_TDEE, data: {
      'activity_level':activityLevel
    }).then((value) {
      var TDEE = value.data['TDEE'];
      userData.user!.neededCalories = TDEE;
      getGoals();
      loadingTDEE = false;
      emit(FitnessUpdateNeededCaloriesSuccessfullyState());
    }).onError((error, stackTrace) {
      loadingTDEE = false;
      print(error.toString());
      emit(FitnessUpdateNeededCaloriesErrorState());
    });
  }
  bool loadingImageScan = false;
  ScanImageModel? scanImageModel; // Change late to nullable

  Future<void> scanImage(File image) async {
    loadingImageScan = true;
    emit(FitnessImageScanLoadingState());
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      Response response = await DioHelper.postData(
        url: IMAGE_SCAN,
        data: formData,
      );

      scanImageModel = ScanImageModel.fromJson(response.data);
      loadingImageScan = false;
      emit(FitnessImageScanSuccessfullyState());
    } catch (error) {
      print(error.toString());
      loadingImageScan = false;
      showToast(text: 'Failed to send image', state: ToastStates.ERROR);
      emit(FitnessImageScanErrorState());
    }
  }


  bool loadingAddImage = false;
  late ImageModel imageModel;

  Future<void> addImage(File image,String mass) async {
    loadingAddImage = true;
    emit(FitnessAddImageLoadingState());

    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: fileName),
        'mass': mass,
      });

      Response response = await DioHelper.postData(
        url: IMAGE_ADD,
        data: formData,
      );

      imageModel = ImageModel.fromJson(response.data);
      loadingAddImage = false;

     await getGoals();
     await getMealsHistory();
      emit(FitnessAddImageSuccessfullyState());
    } catch (error) {
      print(error.toString());
      loadingAddImage = false;
      showToast(text: 'Add image not sent successfully', state: ToastStates.ERROR);
      emit(FitnessAddImageErrorState());
    }
  }
  bool loadingGoals = false;
  bool redProgressColor = false;
    GoalsModel? goalsModel;
  Future<void> getGoals()async{
    loadingGoals = true;
    emit(FitnessGoalsLoadingState());
    DioHelper.getData(url: GET_GOALS,token: CacheHelper.getData(key: 'token')).then((value) {
      goalsModel = GoalsModel.fromJson(value.data);
      double result = 1- (goalsModel!.data!.remainingCalories!  / userData.user!.neededCalories!.toDouble()).toDouble();

      if(result == 1 || result >1 || result < -1){
        redProgressColor = true;
      }else{
        redProgressColor = false;
      }
      loadingGoals = false;
      emit(FitnessGoalsSuccessfullyState());
    }).onError((error, stackTrace) {
      loadingGoals = false;
      print(error.toString());
      emit(FitnessGoalsErrorState());
    });
  }
   List<dynamic> meals = [];
  Future<void> getMealsHistory()async{
    DioHelper.getData(url: MEALS_HISTORY,token: CacheHelper.getData(key: 'token')).then((value) {

      meals = value.data;
      emit(FitnessMealsHistorySuccessfullyState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(FitnessMealsHistoryErrorState());
    });
  }

  }

