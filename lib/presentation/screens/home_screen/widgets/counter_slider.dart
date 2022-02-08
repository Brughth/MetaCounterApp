import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_counter_app/logic/cubit/counter_cubit.dart';

/// the concept of the widget inspired
/// from [Nikolay Kuchkarov](https://dribbble.com/shots/3368130-Stepper-Touch).
/// i extended  the functionality to be more useful in real world applications
class CounterSlider extends StatefulWidget {
  const CounterSlider({
    required this.initialValue,
    required this.onChanged,
    this.direction = Axis.horizontal,
    this.withSpring = true,
    this.counterColor = const Color(0xFF6D72FF),
    this.dragButtonColor = Colors.white,
    this.buttonsColor = Colors.white,
  }) : super();

  final Axis direction;
  final int initialValue;

  final ValueChanged<int> onChanged;
  final bool withSpring;

  final Color counterColor;
  final Color dragButtonColor;
  final Color buttonsColor;

  @override
  _Stepper2State createState() => _Stepper2State();
}

class _Stepper2State extends State<CounterSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late int _value;
  double? _startAnimationPosX;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue; //? ?? = 0
    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: widget.direction == Axis.horizontal ? 280.0 : 120.0,
        height: widget.direction == Axis.horizontal ? 120.0 : 280.0,
        child: Material(
          type: MaterialType.canvas,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(60.0),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.blueGrey.shade200
              : Colors.blueGrey.shade600,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: widget.direction == Axis.horizontal ? 10.0 : null,
                bottom: widget.direction == Axis.horizontal ? null : 10.0,
                child: Icon(
                  Icons.remove,
                  size: 40.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              Positioned(
                right: widget.direction == Axis.horizontal ? 10.0 : null,
                top: widget.direction == Axis.horizontal ? null : 10.0,
                child: Icon(
                  Icons.add,
                  size: 40.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              GestureDetector(
                onHorizontalDragStart: _onPanStart,
                onHorizontalDragUpdate: _onPanUpdate,
                onHorizontalDragEnd: _onPanEnd,
                child: SlideTransition(
                  position: _animation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: widget.dragButtonColor,
                      shape: const CircleBorder(),
                      elevation: 5.0,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                child: child, scale: animation);
                          },
                          child: const Icon(
                            Icons.trip_origin,
                            size: 40.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;
    if (widget.direction == Axis.horizontal) {
      return ((local.dx * 0.75) / box.size.width) - 0.4;
    } else {
      return ((local.dy * 0.75) / box.size.height) - 0.4;
    }
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.stop();
    bool isHor = widget.direction == Axis.horizontal;
    bool changed = false;
    if (_controller.value <= -0.20) {
      //setState(() => isHor ? _value-- : _value++);
      context.read<CounterCubit>().decrement();
    } else if (_controller.value >= 0.20) {
      //setState(() => isHor ? _value++ : _value--);
      context.read<CounterCubit>().increment();
    }

    final SpringDescription _kDefaultSpring =
        SpringDescription.withDampingRatio(
      mass: 0.9,
      stiffness: 250.0,
      ratio: 0.6,
    );

    _controller.animateWith(
        SpringSimulation(_kDefaultSpring, _startAnimationPosX!, 0.0, 0.0));
  }
}
