import 'package:e_commerce_app/utils/appcolors.dart';
import 'package:e_commerce_app/widgets/build_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../api_service/api_service.dart';
import '../models/product_response_mdoel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentOfferIndex = 0;
  bool _isLoading = true;
  bool _isBannerLoading = true;

  List<ProductResponseModel> products = [];
  List<String> bannerImages = [];

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.cake, 'label': 'Cup Cake'},
    {'icon': Icons.celebration, 'label': 'Cakes'},
    {'icon': Icons.donut_small, 'label': 'Donuts'},
    {'icon': Icons.cookie, 'label': 'Cookies'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchBanners();
  }

  Future<void> _fetchProducts() async {
    final apiService = ApiService();
    final productResponse = await apiService.getProducts();

    setState(() {
      if (productResponse != null && productResponse.productDetails != null) {
        products = List<ProductResponseModel>.from(productResponse.productDetails!);
      } else {
        products = [];
      }
      _isLoading = false;
    });
  }

  Future<void> _fetchBanners() async {
    final apiService = ApiService();
    final bannerResponse = await apiService.fetchBannerData();

    setState(() {
      if (bannerResponse != null && bannerResponse.categoryList != null) {
        bannerImages = bannerResponse.categoryList!
            .map((banner) => banner.imageurl ?? '')
            .toList();
      }
      _isBannerLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Appcolors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Appcolors.teal,
        unselectedItemColor: Appcolors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 210,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BuildTextWidget(text: 'Location', fontSize: 12, color: Appcolors.white),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16, color: Appcolors.white),
                                  const SizedBox(width: 4),
                                  BuildTextWidget(
                                    text: 'Muwailah Commercial',
                                    fontWeight: FontWeight.bold,
                                    color: Appcolors.white,
                                  ),
                                ],
                              ),
                              BuildTextWidget(text: 'Sharjah', fontSize: 12, color: Appcolors.white),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.shopping_cart_outlined, color: Appcolors.white),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications_none, color: Appcolors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for cakes, cookies, etc.',
                          hintStyle: TextStyle(color: Appcolors.grey),
                          filled: true,
                          fillColor: Appcolors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.search, color: Appcolors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Special Offers
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: BuildTextWidget(
                  text: 'Special Offers',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _isBannerLoading
                  ? const Center(child: CircularProgressIndicator())
                  : bannerImages.isEmpty
                  ? const Center(child: Text("No banners found"))
                  : Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: bannerImages.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          bannerImages[index],
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 150,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentOfferIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(bannerImages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentOfferIndex == index ? 12 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentOfferIndex == index
                              ? Appcolors.teal
                              : Colors.grey.shade400,
                        ),
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    BuildTextWidget(
                      text: 'Categories',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    BuildTextWidget(text: 'See All', color: Appcolors.teal),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.teal.shade50,
                          child: Icon(categories[index]['icon'], color: Colors.teal),
                        ),
                        const SizedBox(height: 8),
                        Text(categories[index]['label']),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Featured Products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    BuildTextWidget(
                      text: 'Featured Products',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    BuildTextWidget(text: 'See All', color: Appcolors.teal),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                height: 260,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      width: 160,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Appcolors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  product.productDetails![index].imageurl ?? '',
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          BuildTextWidget(text:
                            product.productDetails![index].productname?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const BuildTextWidget(text: 'ADD', color: Appcolors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
