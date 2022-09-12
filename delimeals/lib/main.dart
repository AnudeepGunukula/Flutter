// ignore_for_file: prefer_const_constructors

import 'package:delimeals/screens/categories_screen.dart';
import 'package:delimeals/screens/category_meals_screen.dart';
import 'package:delimeals/screens/filters_screen.dart';
import 'package:delimeals/screens/meal_detail_screen.dart';
import 'package:delimeals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
              fontSize: 19,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        '/category-meals': (ctx) => CategoryMealsScreen(),
        '/meal-detail': (ctx) => MealDetailScreen(),
        '/filters': (ctx) => FiltersScreen(),
      },
      // onGenerateRoute: (settings) {       // we can dynamically check and return to different pages
      //   print(settings.arguments);
      //   return MaterialPageRoute(
      //     builder: (context) => CategoriesScreen(),
      //   );
      // },
      onUnknownRoute: (settings) {
        // like 404 error page
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DeliMeals',
        ),
      ),
      body: Center(
        child: Text('Navigation here!'),
      ),
    );
  }
}
