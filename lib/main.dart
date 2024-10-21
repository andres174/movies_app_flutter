import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart';


void main() => runApp(const AppState());


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider(
          create:(context) =>  MoviesProvider(),
          lazy: false, 
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'details': (context) => const DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 255, 165, 56),
          elevation: 0,
          
        )
      ),
    );
  }
}