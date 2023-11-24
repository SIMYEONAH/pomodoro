import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/timeoption.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  static const defalutFocusTime = 1500;
  static const defalutRestTime = 300;
  static const focus = 'focus';
  static const rest = 'rest';
  int focusTime = defalutFocusTime;
  int restTime = defalutRestTime;
  bool isRunning = false;
  String current = focus;
  int round = 0;
  int goal = 0;
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

  void onStartTimer() {
    setState(() {
      if (current == focus) {
        focusTimer = Timer.periodic(const Duration(seconds: 1), onTick);
      }
      if (current == rest) {
        restTimer = Timer.periodic(const Duration(seconds: 1), onRest);
      }
      isRunning = true;
    });
  }

  void onPauseTimer() {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 30,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            format(current == focus ? focusTime : restTime)
                                .first,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w800,
                              backgroundColor: Theme.of(context).cardColor,
                              fontSize: 50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          ":",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 30,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            format(current == focus ? focusTime : restTime)
                                .last,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w800,
                              backgroundColor: Theme.of(context).cardColor,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TimerOption(
                            minute: 15,
                            onTimeSelected: _handleTimerOptionSelected,
                          ),
                          const SizedBox(width: 10),
                          TimerOption(
                            minute: 20,
                            onTimeSelected: _handleTimerOptionSelected,
                          ),
                          const SizedBox(width: 10),
                          TimerOption(
                            minute: 25,
                            onTimeSelected: _handleTimerOptionSelected,
                          ),
                          const SizedBox(width: 10),
                          TimerOption(
                            minute: 30,
                            onTimeSelected: _handleTimerOptionSelected,
                          ),
                          const SizedBox(width: 10),
                          TimerOption(
                            minute: 35,
                            onTimeSelected: _handleTimerOptionSelected,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    IconButton(
                      onPressed: isRunning ? onPauseTimer : onStartTimer,
                      icon: Icon(
                        isRunning ? Icons.pause_circle : Icons.play_circle,
                      ),
                      color: Theme.of(context).primaryColorLight,
                      iconSize: 100,
                    ),
                    IconButton(
                      onPressed: onResetPressed,
                      icon: const Icon(
                        Icons.refresh,
                      ),
                      color: Theme.of(context).primaryColorLight,
                      iconSize: 20,
                    ),
                  ],
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$round/4",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "ROUND",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '$goal/12',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'GOAL',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
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
      ),
    );
  }
}
