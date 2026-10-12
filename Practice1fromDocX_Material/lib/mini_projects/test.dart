//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const BookApp());
// }
//
// // 1. Main application
// class BookApp extends StatelessWidget {
//   const BookApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Async Book Loader',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.teal,
//         ),
//         useMaterial3: true,
//       ),
//       home: const BookHomePage(),
//     );
//   }
// }
//
// // 2. Book model
// class Book {
//   final String title;
//   final String author;
//
//   const Book({
//     required this.title,
//     required this.author,
//   });
// }
//
// // 3. Fake asynchronous data source
// Future<List<Book>> fetchBooks({
//   bool shouldFail = false,
// }) async {
//   // Simulate network delay.
//   await Future.delayed(
//     const Duration(seconds: 2),
//   );
//
//   // Simulate a server error when requested.
//   if (shouldFail) {
//     throw Exception('Server connection failed!');
//   }
//
//   return const [
//     Book(
//       title: 'Quran Tafsir',
//       author: 'Ibn Kathir',
//     ),
//     Book(
//       title: 'Riyad as-Salihin',
//       author: 'Imam Nawawi',
//     ),
//     Book(
//       title: 'Ar-Raheeq Al-Makhtum',
//       author: 'Safiur Rahman',
//     ),
//     Book(
//       title: 'Al-Adab Al-Mufrad',
//       author: 'Imam Bukhari',
//     ),
//     Book(
//         title: 'Fortress of the Muslim',
//         author: 'Said bin Ali',
//     ),
//   ];
// }
//
// // 4. Home screen
// class BookHomePage extends StatefulWidget {
//   const BookHomePage({super.key});
//
//   @override
//   State<BookHomePage> createState() =>
//       _BookHomePageState();
// }
//
// class _BookHomePageState extends State<BookHomePage> {
//   late Future<List<Book>> booksFuture;
//
//   bool simulateError = false;
//
//   String searchText = '';
//
//   // Create the Future once when the screen initializes.
//   @override
//   void initState() {
//     super.initState();
//     loadBooks();
//   }
//
//   // Create a new Future for initial load or refresh.
//   void loadBooks() {
//     booksFuture = fetchBooks(
//       shouldFail: simulateError,
//     );
//   }
//
//   // Retry after an error or refresh the list.
//   void refreshBooks() {
//     setState(() {
//       loadBooks();
//     });
//   }
//
//   // Toggle simulated server failure.
//   void toggleErrorMode() {
//     setState(() {
//       simulateError = !simulateError;
//       loadBooks();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Async Book Loader',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: refreshBooks,
//             tooltip: 'Refresh books',
//             icon: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//
//       body: Column(
//         children: [
//           // 5. Search field
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   searchText = value.toLowerCase();
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search books...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//             ),
//           ),
//
//           // 6. FutureBuilder
//           Expanded(
//             child: FutureBuilder<List<Book>>(
//               future: booksFuture,
//               builder: (context, snapshot) {
//
//                 // STATE 1: Loading
//                 if (snapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return const Center(
//                     child: Column(
//                       mainAxisAlignment:
//                       MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 16),
//                         Text('Loading books...'),
//                       ],
//                     ),
//                   );
//                 }
//
//                 // STATE 2: Error
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Column(
//                         mainAxisAlignment:
//                         MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.error_outline,
//                             color: Colors.red,
//                             size: 64,
//                           ),
//                           const SizedBox(height: 12),
//                           const Text(
//                             'Oops! Something went wrong.',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             '${snapshot.error}',
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 20),
//                           FilledButton.icon(
//                             onPressed: refreshBooks,
//                             icon: const Icon(Icons.refresh),
//                             label: const Text('Retry'),
//                           ),
//                           TextButton(
//                             onPressed: toggleErrorMode,
//                             child: const Text(
//                               'Toggle simulated error',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//
//                 // STATE 3: Success
//                 final books = snapshot.data ?? [];
//
//                 // Filter books locally without fetching again.
//                 final filteredBooks = books.where((book) {
//                   return book.title
//                       .toLowerCase()
//                       .contains(searchText);
//                 }).toList();
//
//                 // STATE 4: Empty result
//                 if (filteredBooks.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       'No books found.',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//                 }
//
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(
//                             Icons.menu_book,
//                             color: Colors.teal,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             '${filteredBooks.length} books found',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Spacer(),
//                           TextButton(
//                             onPressed: toggleErrorMode,
//                             child: const Text('Test error'),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Expanded(
//                       child: ListView.builder(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                         ),
//                         itemCount: filteredBooks.length,
//                         itemBuilder: (context, index) {
//                           final book = filteredBooks[index];
//
//                           return Card(
//                             margin: const EdgeInsets.only(
//                               bottom: 10,
//                             ),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundColor:
//                                 Colors.teal.shade50,
//                                 child: const Icon(
//                                   Icons.menu_book,
//                                   color: Colors.teal,
//                                 ),
//                               ),
//                               title: Text(
//                                 book.title,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Text(book.author),
//                               trailing: const Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 16,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
