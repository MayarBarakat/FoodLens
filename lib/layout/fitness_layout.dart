import 'package:FeedLens/layout/cubit/fitness_cubit.dart';
import 'package:FeedLens/layout/utils/rive_utils.dart';
import 'package:FeedLens/shared/network/local/cache_helper.dart';
import 'package:FeedLens/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class FitnessLayout extends StatefulWidget {
  const FitnessLayout({super.key});

  @override
  State<FitnessLayout> createState() => _FitnessLayoutState();
}

class _FitnessLayoutState extends State<FitnessLayout> {
  RiveAsset selectedBottomNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    var cubit = FitnessCubit.get(context);
    return BlocConsumer<FitnessCubit, FitnessState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            body:(cubit.userDataLoading)?
            const Center(child: CircularProgressIndicator(color: defaultColor,))
                :cubit.noInternet?
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const Text('NO Internet Connection',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: defaultColor),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => cubit.getUserData(token: CacheHelper.getData(key: 'token')),
                  icon: const Icon(Icons.refresh_outlined),
                  label: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(
                    primary: defaultColor,
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),): IndexedStack(
              index: cubit.currentIndex,
              children: cubit.bottomScreen,
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(bottomNavs.length,
                            (index) =>GestureDetector(
                          onTap: (){
                            bottomNavs[index].input!.change(true);
                            if(bottomNavs[index] != selectedBottomNav){
                              setState(() {
                                selectedBottomNav = bottomNavs[index];
                              });
                            }
                            cubit.changeBottom(index);
                            Future.delayed( const Duration(seconds: 1),(){
                              bottomNavs[index].input!.change(false);

                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(bottom: 2),
                                  height: 4,
                                  width: bottomNavs[index] == selectedBottomNav? 20 : 0,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF81B4FF),
                                      borderRadius: BorderRadius.all(Radius.circular(12))
                                  )),
                              SizedBox(
                                height: 36,
                                width: 36,
                                child: Opacity(
                                  opacity: bottomNavs[index] == selectedBottomNav? 1: 0.5,
                                  child: RiveAnimation.asset(
                                    bottomNavs.first.src,
                                    artboard: bottomNavs[index].artBoard,
                                    onInit: (artboard){
                                      StateMachineController controller = RiveUtils.getRiveController(
                                          artboard,
                                          stateMachineName: bottomNavs[index].stateMachineName
                                      );
                                      bottomNavs[index].input = controller.findSMI("active") as SMIBool;
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
class RiveAsset{
  final String artBoard, stateMachineName,title,src;
  late SMIBool? input;

  RiveAsset(this.src,{
    required this.artBoard,
    required this.stateMachineName,
    required this.title,
    this.input

  });

  set setInput(SMIBool status){
    input = status;
  }
}

List<RiveAsset>bottomNavs = [
  RiveAsset("assets/images/animated_icon_set_-_1_color.riv", artBoard: "HOME", stateMachineName: "HOME_interactivity", title: "Search"),
  RiveAsset("assets/images/animated_icon_set_-_1_color.riv", artBoard: "REFRESH/RELOAD", stateMachineName: "RELOAD_Interactivity", title: "Bell"),
  RiveAsset("assets/images/animated_icon_set_-_1_color.riv", artBoard: "USER", stateMachineName: "USER_Interactivity", title: "User"),

  RiveAsset("assets/images/animated_icon_set_-_1_color.riv", artBoard: "SETTINGS", stateMachineName: "SETTINGS_Interactivity", title: "Settings"),
];
