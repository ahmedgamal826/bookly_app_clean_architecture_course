import 'package:clean_architecture_course/Features/home/domain/entities/book_entity.dart';
import 'package:clean_architecture_course/constants.dart';
import 'package:clean_architecture_course/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Bookly(),
    ),
  );

  Hive.registerAdapter(BookEntityAdapter());
  Hive.openBox(kFeaturedBox);
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
    );
  }
}
