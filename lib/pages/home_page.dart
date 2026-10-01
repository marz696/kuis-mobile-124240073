import 'package:flutter/material.dart';

import '../data.dart';
import '../widgets/menu_image.dart';
// ignore: unused_import
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'Semua';
  final Set<int> _favoriteIds = {};

  // Filter kategori
  late final List<String> _categories = [
    'Semua',
    ...{for (final p in catalog) p.type},
    'Favorit',
  ];


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredMenus {
    return catalog.where((product) {
      final bool matchCategory;
      if (_selectedCategory == 'Semua') {
        matchCategory = true;
      } else if (_selectedCategory == 'Favorit') {
        matchCategory = _favoriteIds.contains(product.id);
      } else {
        matchCategory = product.type == _selectedCategory;
      }
      final matchQuery =
          product.productName.toLowerCase().contains(_query.toLowerCase());
      return matchCategory && matchQuery;
    }).toList();
  }

  void _toggleFavorite(int id) {
    setState(() {
      if (!_favoriteIds.remove(id)) {
        _favoriteIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredMenus;

    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: false),
      body: Column(
        children: [
          // Bonus: search menu
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value.trim()),
              decoration: InputDecoration(
                hintText: 'Cari menu...',
                isDense: true,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          // Bonus: filter kategori + favorit
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = category),
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          // Daftar menu (ListView)
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Menu tidak ditemukan'))
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 88),
                    itemBuilder: (context, index) {
                      final menu = items[index];
                      final isFavorite = _favoriteIds.contains(menu.id);

                      return ListTile(
                        isThreeLine: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: Hero(
                          tag: 'menu-image-${menu.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: MenuImage(
                              url: menu.imageUrl,
                              width: 56,
                              height: 56,
                              resolution: 200,
                            ),
                          ),
                        ),
                        title: Text(
                          menu.productName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(menu.type),
                            Text(
                              menu.price,
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.favorite, size: 16, color: Colors.red),
                            Text('${menu.likeCount} likes'),
                            Text('Stock: ${menu.stock}')
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'Favorit',
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onPressed: () => _toggleFavorite(menu.id),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        // Klik menu -> buka Detail, kirim objek menu yang dipilih
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(menu: menu),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
