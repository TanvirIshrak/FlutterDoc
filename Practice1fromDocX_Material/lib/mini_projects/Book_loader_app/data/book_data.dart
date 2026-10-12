
import '../model/book_model.dart';

Future<List<Book>> fetchBooks({
    bool shouldFail = false,
}) async {
  await Future.delayed(
    Duration(seconds: 2),
  );

  if(shouldFail){
    throw Exception("Server Connection Fail!");
  }
  return const [
    Book(
      title: 'Quran Tafsir',
      author: 'Ibn someone',
    ),
    Book(
      title: 'Riyad as-Salihin',
      author: 'Imam Nawawi',
    ),
    Book(
      title: 'Ar-Raheeq Al-Makhtum',
      author: 'Safiur Rahman',
    ),
    Book(
      title: 'Al-Adab Al-Mufrad',
      author: 'Imam Bukhari',
    ),
    Book(
        title: 'Fortress of the Muslim',
        author: 'Said bin Ali',
    ),
  ];
}