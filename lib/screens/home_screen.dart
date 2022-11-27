import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api_flutter_course/consts/global_colors.dart';
import 'package:store_api_flutter_course/screens/categories_screen.dart';
import 'package:store_api_flutter_course/screens/feeds_screen.dart';
import 'package:store_api_flutter_course/screens/home_detail_screen.dart';
import 'package:store_api_flutter_course/screens/users_screen.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';

import '../models/products_model.dart';
import '../widgets/appbar_icons.dart';
import '../widgets/feeds_grid.dart';
import '../widgets/feeds_widget.dart';
import '../widgets/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late TextEditingController _textEditingController;
  // List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeDetailScreen(),
    CategoriesScreen(),
    UsersScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Person'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped),
          appBar: AppBar(
            // elevation: 4,
            title: const Text('Home'),
            leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const CategoriesScreen(),
                  ),
                );
              },
              icon: IconlyBold.category,
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const UsersScreen(),
                    ),
                  );
                },
                icon: IconlyBold.user3,
              ),
            ],
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}
