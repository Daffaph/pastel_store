import 'package:flutter/material.dart';

import '../models/product.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final theme = Theme.of(context);
    final images = p.images.isNotEmpty ? p.images : [p.thumbnail];
    final hasDiscount = p.discountPercentage > 0;
    final finalPrice = p.price * (1 - p.discountPercentage / 100);

    return Scaffold(
      appBar: AppBar(title: Text(p.title, overflow: TextOverflow.ellipsis)),
      body: ListView(
        children: [
          // Galeri gambar (geser kiri-kanan)
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: images.length,
                  onPageChanged: (i) => setState(() => _currentImage = i),
                  itemBuilder: (context, i) => Image.network(
                    images[i],
                    fit: BoxFit.contain,
                    cacheWidth: 600,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, size: 48)),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (i) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == _currentImage
                                ? theme.colorScheme.primary
                                : theme.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Rating + stok
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(p.rating.toStringAsFixed(1)),
                    const SizedBox(width: 16),
                    Text('Stok: ${p.stock}'),
                  ],
                ),
                const SizedBox(height: 12),

                // Harga
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${finalPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (hasDiscount) ...[
                      const SizedBox(width: 8),
                      Text(
                        '\$${p.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('-${p.discountPercentage.toStringAsFixed(0)}%'),
                    ],
                  ],
                ),
                const SizedBox(height: 12),

                // Kategori + brand (brand disembunyikan kalau kosong)
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text(p.category)),
                    if (p.brand.isNotEmpty) Chip(label: Text(p.brand)),
                  ],
                ),
                const Divider(height: 32),

                Text('Deskripsi', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(p.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
