import 'package:clean_architecture_course/Features/home/data/repos/home_repo_impl.dart';
import 'package:clean_architecture_course/Features/home/domain/entities/book_entity.dart';
import 'package:clean_architecture_course/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:clean_architecture_course/Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:clean_architecture_course/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:clean_architecture_course/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:clean_architecture_course/constants.dart';
import 'package:clean_architecture_course/core/functions/setup_service_locator.dart';
import 'package:clean_architecture_course/core/utils/app_router.dart';
import 'package:clean_architecture_course/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setupServiceLocator();

  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);
  Bloc.observer = SimpleBlocObserver();
  runApp(
    const ProviderScope(
      child: Bookly(),
    ),
  );
}

GetIt getIt = GetIt.instance;

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(
            fetchFeaturedBooksUseCase: FetchFeaturedBooksUseCase(
              getIt.get<HomeRepoImpl>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => NewestBooksCubit(
            fetchNewestBooksUseCase: FetchNewestBooksUseCase(
              getIt.get<HomeRepoImpl>(),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
