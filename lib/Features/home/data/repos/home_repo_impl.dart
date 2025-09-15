// import 'package:clean_architecture_course/Features/home/data/data_sources/home_local_data_source.dart';
// import 'package:clean_architecture_course/Features/home/data/data_sources/home_remote_data_source.dart';
// import 'package:clean_architecture_course/Features/home/domain/entities/book_entity.dart';
// import 'package:clean_architecture_course/Features/home/domain/repos/home_repo.dart';
// import 'package:clean_architecture_course/core/errors/failure.dart';
// import 'package:dartz/dartz.dart';

// class HomeRepoImpl extends HomeRepo {
//   final HomeLocalDataSource homeLocalDataSource;
//   final HomeRemoteDataSource homeRemoteDataSource;
//   HomeRepoImpl({
//     required this.homeLocalDataSource,
//     required this.homeRemoteDataSource,
//   });
//   @override
//   Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async{
//     var localFeaturedBooks = homeLocalDataSource.fetchFeaturedBooks();
//     if (localFeaturedBooks.isNotEmpty) {
//       return right(localFeaturedBooks);
//     }
//     var remoteFeaturedBooks = await homeRemoteDataSource.fetchFeaturedBooks();
//     try
//     {
//       return right(remoteFeaturedBooks);
//     }
//     catch (e) {
//       return left(Failure);
//     }
//   }

//   @override
//   Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() {}
// }

import 'package:clean_architecture_course/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_architecture_course/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_architecture_course/Features/home/domain/entities/book_entity.dart';
import 'package:clean_architecture_course/Features/home/domain/repos/home_repo.dart';
import 'package:clean_architecture_course/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({
    required this.homeLocalDataSource,
    required this.homeRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      List<BookEntity> localFeaturedBooks = homeLocalDataSource.fetchFeaturedBooks();
      if (localFeaturedBooks.isNotEmpty) {
        return Right(localFeaturedBooks);
      }

      final remoteFeaturedBooks =
          await homeRemoteDataSource.fetchFeaturedBooks();

      return Right(remoteFeaturedBooks);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      List<BookEntity> localNewest = homeLocalDataSource.fetchNewestBooks();
      if (localNewest.isNotEmpty) {
        return Right(localNewest);
      }

      final remoteNewest = await homeRemoteDataSource.fetchNewestBooks();
      return Right(remoteNewest);
    } catch (e) {
      return Left(Failure());
    }
  }
}
