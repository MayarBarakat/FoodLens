import 'package:FeedLens/layout/cubit/fitness_cubit.dart';
import 'package:FeedLens/layout/fitness_layout.dart';
import 'package:FeedLens/module/auth_pages/login/login_screen.dart';
import 'package:FeedLens/shared/network/local/cache_helper.dart';
import 'package:FeedLens/shared/network/remote/dio_helper.dart';
import 'package:FeedLens/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  bool isLoggedIn = await CacheHelper.getData(key: 'isLoggedIn') ?? false;
  String tokenFromStart = 'null';
  if (isLoggedIn) {
    tokenFromStart = CacheHelper.getData(key: 'token');
  }
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    tokenFromStart: tokenFromStart,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String tokenFromStart;

  const MyApp(
      {Key? key, required this.isLoggedIn, required this.tokenFromStart});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
            isLoggedIn ? FitnessCubit():FitnessCubit()..getUserData(token:tokenFromStart),
          ),

        ],
        child: BlocConsumer<FitnessCubit, FitnessState>(
            listener: (context, state) {},
            builder: (context, state) {
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: theme(),
                home:isLoggedIn? FitnessLayout(): LoginScreen(),
              );
            }));

  }
}