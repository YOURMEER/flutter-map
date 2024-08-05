import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  final List<String> _places = [
    'Karachi Beach',
    'Karachi Museum',
    'Karachi Zoo',
    'Karachi Park',
    'Karachi Mal l'
  ]; // Example places

  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTween;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _suggestions = _places
          .where((place) => place.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // Prioritize places containing 'Karachi' at the top
      _suggestions.sort((a, b) {
        if (a.toLowerCase().contains('karachi') && !b.toLowerCase().contains('karachi')) {
          return -1;
        }
        if (!a.toLowerCase().contains('karachi') && b.toLowerCase().contains('karachi')) {
          return 1;
        }
        return 0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.blueAccent,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_colorTween.value!, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Floating elements
          Positioned(
            top: 50,
            left: 30,
            child: FloatingElement(),
          ),
          Positioned(
            top: 200,
            right: 30,
            child: FloatingElement(),
          ),
          Positioned(
            bottom: 100,
            left: 80,
            child: FloatingElement(),
          ),
          Positioned(
            bottom: 50,
            right: 100,
            child: FloatingElement(),
          ),
          // Foreground content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Search bar
                        TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.green),
                            hintText: 'Search Places',
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: const Icon(Icons.airline_stops_sharp, color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            isDense: true,
                          ),
                        ),
                        if (_suggestions.isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _suggestions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_suggestions[index]),
                                  onTap: () {
                                    _searchController.text = _suggestions[index];
                                    _suggestions.clear();
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Featured section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Featured Places',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Carousel
                  SizedBox(
                    height: 200,
                    child: PageView(
                      children: [
                        FeaturedCard(
                          imageUrl: 'https://media.istockphoto.com/id/184944186/photo/quaid-e-azam.jpg?s=612x612&w=0&k=20&c=7mRHDKfBWbpmiTto_w_oMm4EeboU9tEDO_JXke01P5I=',
                          title: 'Mazar-e-Quaid-e-Azam',
                        ),
                        FeaturedCard(
                          imageUrl: 'https://as2.ftcdn.net/v2/jpg/00/86/27/75/1000_F_86277577_39uTmGWGkm2cCtFc8OJMtW2m2DOMj46c.jpg',
                          title: 'Scenic Mountain',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Categories
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryIcon(icon: Icons.star, label: 'Popular'),
                        CategoryIcon(icon: Icons.directions_off, label: 'Off Beat'),
                        CategoryIcon(icon: Icons.fitness_center, label: 'Calisthenics'),
                        CategoryIcon(icon: Icons.self_improvement, label: 'Yoga Class'),
                        CategoryIcon(icon: Icons.more_horiz, label: 'More'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Place cards
                  const PlaceCard(
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqurACjGGrn1wqczX_txzubXvwh0xf2b7Y_A&s',
                    title: 'Beautiful Beach',
                    category: 'Popular',
                    date: '5-10 August',
                    price: '\$300/Night',
                    rating: 4.7,
                    peopleGoing: 20,
                  ),
                  const PlaceCard(
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlq0SgynwtB_e0M62vPhDrNIg-pbHzp-vA8Q&s',
                    title: 'Tropical Paradise',
                    category: 'Luxury',
                    date: '12-18 December',
                    price: '\$500/Night',
                    rating: 4.9,
                    peopleGoing: 10,
                  ),
                  const PlaceCard(
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWdTmVYqaIiCqFycyHtpKD1LuOHGEhp1WoeenOpTMVOBtMiWXMhdhS2ULBBLOAXQBjRYo&usqp=CAU',
                    title: 'Manali Sunalamama',
                    category: 'Off-Beat',
                    date: '17-22 September',
                    price: '\$250/Night',
                    rating: 4.5,
                    peopleGoing: 13,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String date;
  final String price;
  final double rating;
  final int peopleGoing;

  const PlaceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.date,
    required this.price,
    required this.rating,
    required this.peopleGoing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  category,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: Colors.green, size: 16),
                    const SizedBox(width: 4),
                    Text(price, style: const TextStyle(color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    const SizedBox(width: 4),
                    Text(rating.toString(), style: const TextStyle(color: Colors.black)),
                    const SizedBox(width: 8),
                    Icon(Icons.people, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(peopleGoing.toString(), style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FeaturedCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 6,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
