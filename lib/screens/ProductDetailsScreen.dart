import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/custom_button.dart';
import '../widgets/coffee_size.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final Function(String, double, int) onAddToCart;

  const ProductDetail({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedSize = 1;
  int quantity = 1; // Default quantity is 1

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xff2F2D2C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductImage(),
            SizedBox(height: size.height * 0.02),
            _buildProductInfo(),
            SizedBox(height: size.height * 0.02),
            _buildStaticDetails(size),
            _buildQuantitySelector(),
            _buildFooter(size),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 315,
      height: 226,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(widget.product.imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name!,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Color(0xff2F2D2C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "with Chocolate", // Static additional detail
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff9B9B9B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticDetails(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xffFBBE21)),
                  const SizedBox(width: 5),
                  Text(
                    "4.9",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2F2D2C),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "(230)",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9B9B9B),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _iconFeature(Icons.local_drink),
                  const SizedBox(width: 10),
                  _iconFeature(Icons.bolt),
                ],
              ),
            ],
          ),
          const Divider(color: Color(0xffEAEAEA)),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the foam...",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff9B9B9B),
                  height: 1.64,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Size',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CoffeeSize(
                title: 'S',
                index: 0,
                selectedSize: selectedSize,
                onClick: () {
                  setState(() {
                    selectedSize = 0;
                  });
                },
              ),
              CoffeeSize(
                title: 'M',
                index: 1,
                selectedSize: selectedSize,
                onClick: () {
                  setState(() {
                    selectedSize = 1;
                  });
                },
              ),
              CoffeeSize(
                title: 'L',
                index: 2,
                selectedSize: selectedSize,
                onClick: () {
                  setState(() {
                    selectedSize = 2;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
              ),
              Text(
                '$quantity',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(Size size) {
    return Container(
      height: 121,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price', style: TextStyle(color: Colors.grey)),
                Text(
                  "${(widget.product.price! * quantity).toStringAsFixed(2)}DT",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 217,
            height: 62,
            child: CustomButton(
              onPressed: () {
                widget.onAddToCart(
                  widget.product.name!,
                  widget.product.price!,
                  quantity,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.product.name} added to cart!'),
                  ),
                );
                Navigator.pop(context);
              },
              title: 'Add to Cart',
              colors: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconFeature(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: const Color(0xffC67C4E)),
    );
  }
}
