import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_login_screen.dart'; // for redirect after logout


class ProductListScreen extends StatelessWidget {
   
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Liquid Foundation',
      price: 499.0,
      image: 'assets/images/1.jpg',
      description:
          'This medium-to-full coverage foundation gives a flawless finish while hydrating your skin. Suitable for all skin types and lasts up to 12 hours.',
    ),
    Product(
      id: '2',
      name: 'Matte Lipstick',
      price: 299.0,
      image: 'assets/images/2.jpg',
      description:
          'Rich, velvety color that stays on for hours without smudging. Infused with nourishing oils to keep lips smooth and soft.',
    ),
    Product(
      id: '3',
      name: 'Mascara',
      price: 399.0,
      image: 'assets/images/3.jpg',
      description:
          'Lengthens, thickens, and curls lashes without clumping. Waterproof formula holds your look throughout the day.',
    ),
    Product(
      id: '4',
      name: 'BB Cream',
      price: 349.0,
      image: 'assets/images/4.jpg',
      description:
          'A 3-in-1 product combining moisturizer, sunscreen (SPF 30), and light coverage foundation. Perfect for daily natural makeup looks.',
    ),
    Product(
      id: '5',
      name: 'Eyeliner Pen ',
      price: 259.0,
      image: 'assets/images/5.jpg',
      description:
          'Ultra-fine tip for precise application. Quick-drying and waterproof, ideal for bold or subtle lines that won’t smudge. ',
    ),
    Product(
      id: '6',
      name: 'Blush Palette',
      price: 999.0,
      image: 'assets/images/6.jpg',
      description:
          'A set of blendable shades to add a radiant flush of color. Powder texture suitable for all skin tones and types.',
    ),
    Product(
      id: '7',
      name: 'Highlighter Stick',
      price: 479.0,
      image: 'assets/images/7.jpg',
      description:
          'Cream-to-powder finish that adds a natural glow to cheekbones, brow bones, and the cupid’s bow. Easy to apply and blend.',
    ),
    Product(
      id: '8',
      name: 'Face Primer',
      price: 299.0,
      image: 'assets/images/8.jpg',
      description:
          'Silky, oil-free primer that blurs pores and fine lines while ensuring your makeup stays fresh for hours.',
    ),
    Product(
      id: '9',
      name: 'Setting Spray',
      price: 349.0,
      image: 'assets/images/9.jpg',
      description:
          'Weightless mist that locks in makeup for up to 16 hours. Available in matte or dewy finishes depending on your preference.',
    ),
    Product(
      id: '10',
      name: ' Makeup Remover Wipes',
      price: 599.0,
      image: 'assets/images/10.jpg',
      description:
          'Gentle, alcohol-free wipes that cleanse and remove even waterproof makeup. Enriched with aloe and vitamin E.',
    ),
    Product(
      id: '11',
      name: 'Eyeshadow Palette',
      price: 799.0,
      image: 'assets/images/11.jpg',
      description:
          '12 highly pigmented shades in matte, shimmer, and metallic finishes. Blendable and buildable for day or night looks.',
    ),
    Product(
      id: '12',
      name: 'Lip Gloss',
      price: 429.0,
      image: 'assets/images/12.jpg',
      description:
          'Non-sticky formula that delivers high shine and a soft tint. Hydrates lips with shea butter and vitamin E.',
    ),
    Product(
      id: '13',
      name: 'Concealer',
      price: 699.0,
      image: 'assets/images/13.jpg',
      description:
          'Creamy concealer that covers dark circles, blemishes, and discoloration. Long-lasting and crease-resistant.',
    ),
    Product(
      id: '14',
      name: 'Brow Kit',
      price: 559.0,
      image: 'assets/images/14.jpg',
      description:
          'Includes powder, wax, spoolie brush, and angled applicator. Shapes and defines brows for a natural or bold look.',
    ),
    Product(
      id: '15',
      name: ' Facial Serum (Vitamin C)',
      price: 549.0,
      image: 'assets/images/15.jpg',
      description:
          'Brightening serum that fades dark spots, evens skin tone, and boosts collagen. Lightweight and suitable for daily use.',
    ),
    Product(
      id: '16',
      name: 'Clay Face Mask',
      price: 399.0,
      image: 'assets/images/16.jpeg',
      description:
          'Purifying mask with kaolin clay that absorbs oil, unclogs pores, and smooths skin texture. Use 2–3 times a week.',
    ),
    Product(
      id: '17',
      name: 'Makeup Sponge Blender',
      price: 199.0,
      image: 'assets/images/17.jpg',
      description:
          'Soft, latex-free sponge for applying foundation, concealer, or cream products. Use damp for a flawless, airbrushed finish.',
    ),
    Product(
      id: '18',
      name: 'Lip Balm with SPF',
      price: 299.0,
      image: 'assets/images/18.jpg',
      description:
          'Hydrates and protects lips from UV damage. Infused with jojoba oil and beeswax for smooth, nourished lips.',
    ),
    Product(
      id: '19',
      name: 'Compact Powder',
      price: 349.0,
      image: 'assets/images/19.jpg',
      description:
          'Silky pressed powder that sets makeup, reduces shine, and evens out skin tone. Comes with a mirror and puff for touch-ups.',
    ),
    Product(
      id: '20',
      name: 'Makeup Brush Set (12-Piece)',
      price: 749.0,
      image: 'assets/images/20.jpg',
      description:
          'Professional-grade brush set with soft synthetic bristles. Includes brushes for face, eyes, and lips in a zippered pouch.',
    ),
  ];

   ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronic Devices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OtpLoginScreen()),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (cart.items.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.totalItems.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) =>
            ProductTile(product: products[index]),
      ),
    );
  }
}