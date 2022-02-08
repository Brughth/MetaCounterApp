import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_counter_app/logic/cubit/counter_cubit.dart';
import 'package:meta_counter_app/logic/cubit/theme_cubit.dart';
import 'package:meta_counter_app/presentation/screens/home_screen/widgets/counter_slider.dart';
import 'package:meta_counter_app/presentation/screens/home_screen/widgets/flare_vector.dart';
import 'package:meta_counter_app/presentation/screens/home_screen/widgets/plasma_background.dart';

class CounterScreen extends StatefulWidget {
  CounterScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  AnimationController? _animationController;
  @override
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const PlasmaBackground(), // Screen Background
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return SwitchListTile(
                  value: state.isDarkTheme,
                  onChanged: (value) {
                    if (value) {
                      context.read<ThemeCubit>().toggleAPPtheme();
                    } else {
                      context.read<ThemeCubit>().toggleAPPtheme();
                    }
                  },
                  title: const Text("Dark Mode"),
                );
              },
            ),
            Positioned(
              top: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAnnimation(),
                  Builder(builder: (context) {
                    _animationController?.forward(from: 0.0);
                    return ZoomIn(
                      duration: const Duration(milliseconds: 400),
                      controller: (controller) =>
                          _animationController = controller,
                      manualTrigger: true,
                      child: Text(
                        context
                            .select((CounterCubit counterCubit) =>
                                counterCubit.state.counter)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              child: CounterSlider(
                initialValue: 0,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
