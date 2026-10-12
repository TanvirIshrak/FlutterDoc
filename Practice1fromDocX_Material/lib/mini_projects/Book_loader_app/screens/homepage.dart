import 'package:flutter/material.dart';
import 'package:practice1fromdocx/mini_projects/Book_loader_app/data/book_data.dart';

import '../model/book_model.dart';

class BookHomePage extends StatefulWidget {
  const BookHomePage({super.key});

  @override
  State<BookHomePage> createState() => _BookHomePageState();
}

class _BookHomePageState extends State<BookHomePage> {

  late Future<List<Book>> booksFuture;
  bool simulateError = false;
  String searchText = '';

  // Create the Future once when the screen initializes.
  @override
  void initState(){
    super.initState();
    loadBooks();
  }

  // Create a new Future for initial load or refresh.
  void loadBooks(){
    booksFuture = fetchBooks(
      shouldFail: simulateError,
    ) ;
  }

  // Retry after an error or refresh the list.
  void refreshBooks(){
    setState(() {
      loadBooks();
    });
  }

  // Toggle simulated server failure.
  void toggleErrorMode(){
    setState(() {
      simulateError = !simulateError;
      loadBooks();
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Async Book Loader",
            style: TextStyle(
                fontWeight: .bold
            ),
        ),
        actions: [
          IconButton(
              onPressed: refreshBooks,
              tooltip: 'Refresh books',
              icon: Icon(Icons.refresh))
        ],
      ),

      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value){
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search books...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
          ),


          // Future Builder
          Expanded(
              child: FutureBuilder<List<Book>>(
                  future: booksFuture,
                  builder: (context, snapshot){

                    // loading
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 15,),
                            Text("Loading Books...")
                          ],
                        ),
                      );
                    }

                    if(snapshot.hasError){
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: .center,
                            children: [
                              Icon(
                                  Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              SizedBox(height: 12,),
                              Text(
                                  "Opps! Something wents wrong!",
                                textAlign: .center,
                                style: TextStyle(
                                  fontWeight: .bold,
                                  fontSize: 18
                                ),
                              ),

                              SizedBox(height: 10,),
                              Text(
                                '${snapshot.error}',
                                textAlign: .center,
                              ),

                              SizedBox(height: 20,),
                              FilledButton.icon(
                                  onPressed: refreshBooks,
                                  icon: Icon(Icons.refresh),
                                  label: Text('Retry'),
                              ),

                              TextButton(
                                  onPressed: toggleErrorMode,
                                  child: Text("Toggle simulated error")
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    // Success
                    final books = snapshot.data?? [];
                    // return Text("Has no data!");

                    // Flutter books locally without fetching again
                    final filteredBooks = books.where((book){
                      return book.title.toLowerCase().contains(searchText);
                    }).toList();

                    if(filteredBooks.isEmpty){
                      return Center(
                        child: Text(
                          'No books found',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            vertical: 8
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.menu_book,
                                color: Colors.teal,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                '${filteredBooks.length} books found',
                                style: TextStyle(
                                  fontWeight: .bold,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: toggleErrorMode,
                                  child: Text("Text error")
                              )
                            ],
                          ),
                        ),

                        Expanded(
                            child: ListView.builder(
                              itemCount: filteredBooks.length,
                                itemBuilder: (context, index){
                                final book = filteredBooks[index];

                                return Card(
                                  margin: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.teal.shade50,
                                      child: const Icon(
                                        Icons.menu_book,
                                        color: Colors.teal,
                                      ),
                                    ),
                                    title: Text(
                                      book.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(book.author),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                  ),
                                );
                                }
                            )
                        )
                      ],
                    );
                  },
              )
          )
        ],
      ),
    );
  }
}










































































