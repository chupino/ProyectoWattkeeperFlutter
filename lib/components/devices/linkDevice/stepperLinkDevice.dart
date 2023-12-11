import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:wattkeeperr/components/devices/linkDevice/stepsLinkDevice.dart';

class StepperLinkDevice extends StatelessWidget {
  final int activeStep;
  const StepperLinkDevice({super.key, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    Color lineColor = Color(0xFF1C2434);
    Color activeIconColor = Theme.of(context).iconTheme.color!;
    Color activeBackground = Theme.of(context).primaryColor;
    Color activeBorder = Theme.of(context).cardColor;
    Color activeText = Theme.of(context).textTheme.bodyLarge!.color!;
    Color finishedBackground = Colors.grey.withOpacity(0.4);
    Color finishedText = Theme.of(context).textTheme.bodyMedium!.color!;
    Color finishedIcon = Colors.grey;

    return EasyStepper(
      activeStep: activeStep,
      steps: StepsLinkDevice.steps,
      lineStyle: LineStyle(
          lineLength: 100,
          lineThickness: 3,
          lineSpace: 4,
          lineType: LineType.normal,
          defaultLineColor: lineColor),
      activeStepBackgroundColor: activeBackground,
      activeStepIconColor: activeIconColor,
      activeStepBorderColor: activeBorder,
      activeStepTextColor: activeText,
      finishedStepBackgroundColor: finishedBackground,
      finishedStepTextColor: finishedText,
      finishedStepIconColor: finishedIcon,
      activeStepBorderType: BorderType.normal,
      borderThickness: 10,
      internalPadding: 15,
      maxReachedStep: 1,
      showLoadingAnimation: false,
      disableScroll: false,
      enableStepTapping: false,
    );
  }
}
