import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CircleAnnimation extends StatelessWidget {
  const CircleAnnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: FlareActor(
        "assets/flares/circles.flr",
        animation: "Alarm",
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.blueGrey.shade200
            : Colors.blueGrey.shade600,
      ),
    );
  }
}
