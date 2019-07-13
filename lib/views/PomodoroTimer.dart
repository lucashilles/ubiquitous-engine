import 'package:flutter/material.dart';
import 'package:pomodoro_timer/models/Pomodoro.dart';
import 'package:provider/provider.dart';

class PomodoroTimer extends StatelessWidget {
  PomodoroTimer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pomodoro pomodoro = Provider.of<Pomodoro>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Tempo da tarefa: ${pomodoro.taskTime}'),
              Text('Pausa curta: ${pomodoro.shortPause}'),
              Text('Pausa longa: ${pomodoro.longPause}'),
              Text('Quantidade: ${pomodoro.taskCount}'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
