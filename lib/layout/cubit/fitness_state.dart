part of 'fitness_cubit.dart';

@immutable
abstract class FitnessState {}

 class FitnessInitial extends FitnessState {}
 class FitnessChangeBottomState extends FitnessState {}


 class FitnessLoginLoadingState extends FitnessState {}
 class FitnessLoginNotAuthState extends FitnessState {}
 class FitnessLoginSuccessfullyState extends FitnessState {}
 class FitnessLoginErrorState extends FitnessState {}

class FitnessSignUpLoadingState extends FitnessState {}
class FitnessSignUpSuccessfullyState extends FitnessState {}
class FitnessSignUpErrorState extends FitnessState {}


class FitnessUserDataLoadingState extends FitnessState {}
class FitnessUserDataSuccessfullyState extends FitnessState {}
class FitnessUserDataErrorState extends FitnessState {}

class FitnessUserUpdateLoadingState extends FitnessState {}
class FitnessUserUpdateSuccessfullyState extends FitnessState {}
class FitnessUserUpdateErrorState extends FitnessState {}


class FitnessLogoutSuccessfullyState extends FitnessState {}
class FitnessLogoutErrorState extends FitnessState {}


class FitnessUpdateNeededCaloriesSuccessfullyState extends FitnessState {}
class FitnessUpdateNeededCaloriesLoadingState extends FitnessState {}
class FitnessUpdateNeededCaloriesErrorState extends FitnessState {}

class FitnessImageScanSuccessfullyState extends FitnessState {}
class FitnessImageScanLoadingState extends FitnessState {}
class FitnessImageScanErrorState extends FitnessState {}

class FitnessAddImageSuccessfullyState extends FitnessState {}
class FitnessAddImageLoadingState extends FitnessState {}
class FitnessAddImageErrorState extends FitnessState {}


class FitnessGoalsSuccessfullyState extends FitnessState {}
class FitnessGoalsLoadingState extends FitnessState {}
class FitnessGoalsErrorState extends FitnessState {}

class FitnessMealsHistorySuccessfullyState extends FitnessState {}
class FitnessMealsHistoryErrorState extends FitnessState {}