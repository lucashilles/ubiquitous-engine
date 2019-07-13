import 'package:flutter/material.dart';
import 'package:pomodoro_timer/models/Pomodoro.dart';
import 'package:provider/provider.dart';

import 'PomodoroTimer.dart';

class ConfigPage extends StatelessWidget {
  ConfigPage({Key key, this.title}) : super(key: key);
  final String title;

  final taskTime = TextEditingController(text: '25');
  final shortTime = TextEditingController(text: '5');
  final longTime = TextEditingController(text: '25');
  final taskCount = TextEditingController(text: '4');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Pomodoro(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Center(
          child: Form(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.taskTime,
                  decoration: InputDecoration(labelText: 'Tempo da tarefa'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.shortTime,
                  decoration: InputDecoration(labelText: 'Pausa curta'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.longTime,
                  decoration: InputDecoration(labelText: 'Pausa longa'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.taskCount,
                  decoration: InputDecoration(labelText: 'Quantidade'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Pomodoro pomodoro = Provider.of<Pomodoro>(context);
            pomodoro.setConfig(
                int.parse(this.taskTime.text),
                int.parse(this.shortTime.text),
                int.parse(this.longTime.text),
                int.parse(this.taskCount.text));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Provider.value(
                  value: pomodoro,
                  child: PomodoroTimer(),
                ),
              ),
            );
          },
          tooltip: 'Iniciar',
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
