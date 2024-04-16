import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Home Page Widget
    const HomePage(), 
    // Orders Page Widget
    const OrdersPage(),
    // Settings Page Widget
    Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: const Center(
        child: Text('Settings Page Content'),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sign Out',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            FirebaseAuth.instance.signOut();
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(
              title: 'Deliveries',
              value: '5', // عدد الوصوليات التي تم توصيلها
            ),
            CustomCard(
              title: 'Rejections',
              value: '2', // عدد الوصوليات التي تم رفضها
            ),
            CustomCard(
              title: 'Net Earnings',
              value: '\$200', // المبلغ الصافي للسائق
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String value;

  const CustomCard({super.key, 
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Page'),
      ),
      body: const Center(
        child: Column(
          children: [
            OrderBox(
              customerNumber: '12345',
              customerLocation: 'New York, USA',
              orderPrice: 100.0,
            ),
            OrderBox(
              customerNumber: '67890',
              customerLocation: 'London, UK',
              orderPrice: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderBox extends StatelessWidget {
  final String customerNumber;
  final String customerLocation;
  final double orderPrice;

  const OrderBox({
    Key? key,
    required this.customerNumber,
    required this.customerLocation,
    required this.orderPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Customer Number: $customerNumber'),
          Text('Customer Location: $customerLocation'),
          Text('Order Price: $orderPrice'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Accept action
                  // Navigate to the Home Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Reject action
                },
                child: const Text('Reject'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
