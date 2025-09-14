import 'package:clean_architecture_course/Features/home/data/models/book_model/book_model.dart';
import 'package:clean_architecture_course/Features/home/domain/entities/book_entity.dart';
import 'package:clean_architecture_course/constants.dart';
import 'package:clean_architecture_course/core/functions/save_books_data.dart';
import 'package:clean_architecture_course/core/services/api_services.dart';


abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourceImpl({required this.apiServices});
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data =
        await apiServices.get('/volumes?Filtering=free-ebooks&q=programming');

    List<BookEntity> books = getBooksList(data);

    saveBooksData(books, kFeaturedBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiServices
        .get('volumes?Filtering=free-ebooks&q=programming&sorting=newest');

    List<BookEntity> books = getBooksList(data);

    saveBooksData(books, kNewestBox);

    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];

    for (var book in data['items']) {
      books.add(BookModel.fromJson(book));
    }
    return books;
  }
}
