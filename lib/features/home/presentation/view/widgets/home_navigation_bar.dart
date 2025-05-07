import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/features/cart/presentation/view/cart_view.dart';
import 'package:furnitrue_app/features/favorite/presintation/view/favorite_view.dart';
import 'package:furnitrue_app/features/home/presentation/view/home_view.dart';
import 'package:furnitrue_app/features/profile/presentation/view/profile_view.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({super.key});

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const FavoriteView(),
    CartView(),
    const OrderTrackingView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.lightTextColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            label: 'Order tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Order Tracking Page'));
}
