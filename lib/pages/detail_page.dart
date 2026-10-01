import 'package:flutter/material.dart';

import '../data.dart';
import '../widgets/menu_image.dart';

class DetailPage extends StatelessWidget {
  
  const DetailPage({super.key, required this.menu});
  
  
  final Product menu;
  

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // kembali ke Home
        ),
        title: Text(menu.productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'menu-image-${menu.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: MenuImage(url: menu.imageUrl, resolution: 900),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              menu.productName,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              menu.type,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              menu.price,
              style: textTheme.titleMedium?.copyWith(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Jumlah Produk',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Icon(Icons.favorite, size: 30, color: Colors.red),
            Text('${menu.likeCount} likes'),
            Text('Stok: ${menu.stock}'),
            const SizedBox(height: 16),
            Text(
              'Ukuran',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${menu.sizes}",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Deskripsi',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(menu.details, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}