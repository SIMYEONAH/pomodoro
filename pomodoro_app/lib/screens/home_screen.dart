import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const defalutFocusTime = 1500;
  static const defalutRestTime = 300;
  static const focus = "focus";
  static const rest = "rest";
  int focusTime = defalutFocusTime;
  int restTime = defalutRestTime;
  bool isRunning = false;
  String current = focus;
  int round = 0;
  int goal = 0;
  int totalPomodoros = 0;
  late Timer focusTimer;
  late Timer restTimer;

  void _handleTimerOptionSelected(int minute) {
    setState(() {
      focusTime = minute * 60;
    });
  }

  void onTick(Timer timer) {
    if (focusTime == 0) {
      restTimer = Timer.periodic(const Duration(seconds: 1), onRest);
      focusTimer.cancel();
      setState(() {
        focusTime = defalutFocusTime;
        current = rest;
        round = round + 1;
      });
    } else {
      setState(() {
        focusTime = focusTime - 1;
      });
    }
    if (round == 4) {
      round = 0;
      goal = goal + 1;
    }
  }

  void onRest(Timer timer) {
    if (restTime == 0) {
      restTimer.cancel();
      setState(() {
        restTime = defalutRestTime;
        current = focus;
        isRunning = false;
      });
    } else {
      setState(() {
        restTime = restTime - 1;
      });
    }
  }

  void onStartPressed() {
    setState(() {
      if (current == focus) {
        focusTimer == Timer.periodic(const Duration(seconds: 1), onTick);
      }
      if (current == rest) {
        restTimer = Timer.periodic(const Duration(seconds: 1), onRest);
      }
    });
  }

  void onPausePressed() {
    if (focusTimer.isActive) {
      focusTimer.cancel();
    } else if (restTimer.isActive) {
      restTimer.cancel();
    }
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    if (isRunning && focusTimer.isActive) {
      focusTimer.cancel();
    } else if (isRunning && restTimer.isActive) {
      restTimer.cancel();
    }
    setState(() {
      isRunning = false;
      focusTime = defalutFocusTime;
      restTime = defalutRestTime;
      current = focus;
    });
  }

  List<String> format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration
        .toString()
        .split('.')
        .first
        .substring(2)
        .toString()
        .split(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 100,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                color: Theme.of(context).cardColor,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outlined,
                ),
              ),
            ),
          ),
          Flexible(
            child: Center(
              child: IconButton(
                iconSize: 70,
                color: Theme.of(context).cardColor,
                onPressed: onResetPressed,
                icon: const Icon(
                  Icons.restart_alt,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
