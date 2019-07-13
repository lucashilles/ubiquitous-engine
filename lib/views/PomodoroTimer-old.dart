import 'package:flutter/material.dart';
import 'package:pomodoro_timer/models/Pomodoro.dart';

class PomodoroTimer extends StatelessWidget {
  final Pomodoro config;

  PomodoroTimer({Key key, @required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text('Tempo da tarefa: ${config.taskTime}'),
              Text('Pausa curta: ${config.shortPause}'),
              Text('Pausa longa: ${config.longPause}'),
              Text('Quantidade: ${config.taskCount}'),
              StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text('Done');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text('Waiting');
                  }
                  return Text(snapshot.data.toString());
                },
                initialData: 0,
                stream: _stream(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<int> _stream() {
    Duration interval = Duration(seconds: 1);
    Stream<int> stream = Stream<int>.periodic(interval, (int v) {
      return v;
    });
    stream = stream.take(59);
    return stream;
  }
}
