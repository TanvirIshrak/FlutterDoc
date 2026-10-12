// import 'package:flutter/material.dart';
//
// class AsyncPractice extends StatefulWidget {
//   const AsyncPractice({super.key});
//
//   @override
//   State<AsyncPractice> createState() => _AsyncPracticeState();
// }
//
// class _AsyncPracticeState extends State<AsyncPractice> {
//
//   Future<String> getMsg(){
//     return Future.delayed(
//         Duration(seconds: 3) ,
//             (){
//               return "Awain successful";
//             },
//     );
//   }
//
//   Future<void> showmsg() async{
//     String msg = await getMsg();
//
//     print(msg);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Async Practice"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             // onPressed: (){
//             //   getMsg().then((msg){  // if i want to print the msg without awain
//             //     print(msg);
//             //   });
//         // }
//             onPressed: showmsg,
//             child: Text("Get Message"),
//         ),
//       ),
//     );
//   }
// }




//challange 4

import 'package:flutter/material.dart';

class AsyncPractice extends StatefulWidget {
  const AsyncPractice({super.key});

  @override
  State<AsyncPractice> createState() => _AsyncPracticeState();
}

class _AsyncPracticeState extends State<AsyncPractice> {
  late Future<String> myfuture;

  Future<String> getMsg(){
    return Future.delayed(
      const Duration(seconds: 2),
        (){
          return "Await successfully loaded";
        }
    );
  }

  Future<String> getError(){
    return Future.delayed(
      Duration(seconds: 2),
        () => throw Exception("Something wents wrong!")
    );
  }
  @override
  void initState(){
    super.initState();
    myfuture = getMsg();
  }

  void showSuccess(){
    setState(() {
      myfuture = getMsg();
    });
  }
  void showError(){
    setState(() {
      myfuture = getError();
    });
  }
  void showLoading(){
    setState(() {
      myfuture = Future.delayed(
        Duration(seconds: 2),
          ()=> "Loading...!"
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data load indecator"),
      ),
      body: Column(
        // mainAxisAlignment: .center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,

            children: [
              ElevatedButton(
                  onPressed: showSuccess,
                  child: Text("Success")
              ),
              ElevatedButton(
                  onPressed: showError,
                  child: Text("Error")
              ),
              ElevatedButton(
                  onPressed: showLoading,
                  child: Text("Loading")
              ),
            ],
          ),

          Expanded(
            child: Center(
              child: FutureBuilder<String>(
                future: myfuture,
                builder: (context, snapshot){
                  //Data আসার আগে loading দেখাবে
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }


                  if(snapshot.hasData){
                    return Column(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green,
                          size: 60,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          snapshot.data!,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: .bold
                          ),
                        )
                      ],
                    );
                  }
                  if(snapshot.hasError){
                    return Column(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        SizedBox(height: 20,),
                        Text("Something wents wrong!"),
                      ],
                    );
                  }

                  return Text("Has no data!");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

