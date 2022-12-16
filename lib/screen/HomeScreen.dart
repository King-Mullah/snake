import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<int> snakeposition = [45, 65, 85, 105];
  int numberofSquares = 760;
  static var RandomNumber = Random();
  int food = RandomNumber.nextInt(700);

  void startgame() {
    snakeposition = [45, 65, 85, 105];
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        showGameOverScreen();
      }
    });
  }

  var direction = 'down';

  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakeposition.last > 740) {
            snakeposition.add(snakeposition.last + 20 - 760);
          } else {
            snakeposition.add(snakeposition.last + 20);
          }
          break;

        case 'up':
          snakeposition.last < 20
              ? snakeposition.add(snakeposition.last - 20 + 760)
              : snakeposition.add(snakeposition.last - 20);
          break;

        case 'right':
          (snakeposition.last + 1) % 20 == 0
              ? snakeposition.add(snakeposition.last + 1 - 20)
              : snakeposition.add(snakeposition.last + 1);
          break;

        case 'left':
          snakeposition.last % 20 == 0
              ? snakeposition.add(snakeposition.last - 1 + 20)
              : snakeposition.add(snakeposition.last - 1);
          break;

        default:
      }

      if (snakeposition.last == food) {
        generateFood();
      } else {
        snakeposition.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                } else if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                }
              },
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberofSquares,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20),
                  itemBuilder: (BuildContext context, int index) {
                    if (snakeposition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }
                    if (index == food) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    startgame();
                  },
                  child: const Text('start',
                      style: TextStyle(color: Colors.black54, fontSize: 20))),
              const Text('@ MorrisMadeIt',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))
            ],
          ))
        ],
      ),
    );
  }

  void generateFood() {
    food = RandomNumber.nextInt(700);
  }

  bool gameOver() {
    for (int i = 0; i < snakeposition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakeposition.length; j++) {
        if (snakeposition[i] == snakeposition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('GameOver'),
            content: Text('Your score is${snakeposition.length}'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startgame();
                  },
                  child: const Text('Restart')),
            ],
          );
        });
  }
}
