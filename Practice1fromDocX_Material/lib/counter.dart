import 'package:flutter/material.dart';
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter=0;
  void _increment(){
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: .center,
        children: [
          Column(
            mainAxisAlignment: .center,
            children: [
              GestureDetector(
                onTap: (){
                  _increment();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                  ),
                  child: Center(
                    child: Text("Counter", style: TextStyle(fontSize: 20,color: Colors.white))
                    ),

                ),
              ),
              SizedBox(height: 30,),

            ],
          ),
          Text("Count : $_counter", style: TextStyle(fontSize: 20),)
        ],

      ),

    );
  }
}
