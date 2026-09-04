import 'package:flutter/material.dart';
import 'package:store_explorer/features/favorite/presentation/page/favorites_page.dart';
import 'package:store_explorer/features/products/presentation/pages/products_page.dart';

class MainRouterPage extends StatefulWidget {
  const MainRouterPage({super.key});

  @override
  State<MainRouterPage> createState() => _MainRouterPageState();
}

class _MainRouterPageState extends State<MainRouterPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
     ProductsPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'منتجات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'مفضلة',
          ),
        ],
      ),
    );
  }
}


