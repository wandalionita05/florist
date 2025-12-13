import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:florist/views/common_widgets/appBar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allProducts = [
    {
      "image":
          "https://cdn.pixabay.com/photo/2014/07/14/11/44/bridal-393049_1280.jpg",
      "name": "Wedding Bucket",
      "price": "Rp 120.000",
      "rating": 4.8,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2025/03/26/09/05/postcard-9494030_1280.jpg",
      "name": "Bucket Wisuda + Boneka",
      "price": "Rp 150.000",
      "rating": 4.9,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2016/05/27/22/25/roses-1420719_1280.jpg",
      "name": "Bucket Mawar Elegan",
      "price": "Rp 130.000",
      "rating": 4.8,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2018/07/17/21/49/flower-bouquet-3545096_1280.jpg",
      "name": "Bucket Wisuda Premium",
      "price": "Rp 190.000",
      "rating": 4.9,
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2020/02/11/10/20/bouquet-4839049_1280.jpg",
      "name": "Wisuda Bucket Buah",
      "price": "Rp 200.000",
      "rating": 5.0,
    },
  ];

  late List<Map<String, dynamic>> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts);
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts
            .where((product) =>
                product["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                CupertinoIcons.search,
                size: 20,
                color: Color(0xFFE0849A),
              ),
              SizedBox(width: 8),
              Text(
                "Search",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "What are you looking for?",
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Color(0xFFE0849A),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Results",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      "Produk tidak ditemukan 😢",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product["image"],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["name"],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        product["rating"].toString(),
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product["price"],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFE0849A),
                                    ),
                                  ),
                                ],
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
    );
  }
}
