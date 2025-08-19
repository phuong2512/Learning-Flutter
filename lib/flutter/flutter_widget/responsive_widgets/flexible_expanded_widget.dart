import 'package:flutter/material.dart';

class FlexibleExpandedWidget extends StatelessWidget {
  const FlexibleExpandedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flexible / Expanded')),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Expanded\n',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    width: 200,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Flexible\n(tight)',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    width: 200,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Flexible\n(loose)',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
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
