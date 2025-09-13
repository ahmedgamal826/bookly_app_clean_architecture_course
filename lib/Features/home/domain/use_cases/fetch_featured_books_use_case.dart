import 'package:clean_architecture_course/Features/home/domain/entities/book_entity.dart';
import 'package:clean_architecture_course/Features/home/domain/repos/home_repo.dart';
import 'package:clean_architecture_course/core/errors/failure.dart';
import 'package:clean_architecture_course/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, NoParams> {
  final HomeRepo homeRepo;
  FetchFeaturedBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParams? params]) {
    return homeRepo.fetchFeaturedBooks();
  }
}


