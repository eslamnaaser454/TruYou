import 'package:flutter/material.dart';

class TruYouPlusPage extends StatelessWidget {
  const TruYouPlusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: TruYouPlus(
            onClose: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
            onGoPlusNow: () {}, // Removed print statement
            onLifetimePurchase: () {}, // Removed print statement
          ),
        ),
      ),
    );
  }
}

class TruYouPlus extends StatelessWidget {
  final VoidCallback? onClose;
  final VoidCallback? onGoPlusNow;
  final VoidCallback? onLifetimePurchase;
  final String price;
  final String duration;

  const TruYouPlus({
    Key? key,
    this.onClose,
    this.onGoPlusNow,
    this.onLifetimePurchase,
    this.price = "76.99",
    this.duration = "Lifetime",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Close button with overlay icon
          Positioned(
            top: 22,
            left: 29,
            child: GestureDetector(
              onTap: onClose,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Image.asset(
                      'Media/icons/Groupyellow.png',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main content
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 47),
                // Brain logo with Plus badge
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'Media/images/goldbrain.png',
                      width: 82,
                      height: 82,
                    ),
                    Positioned(
                      right: -14,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // TruYou Plus title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'Media/icons/flash.png',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'TruYou Plus',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                const Text(
                  'Remove ads with Truyou plus and\nget free experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 35),

                // Features list
                _buildFeatureItem('Remove ads', 'Media/icons/check.png'),
                _buildFeatureItem(
                    'Unlimited chat-bot', 'Media/icons/check.png'),
                _buildFeatureItem('Unlimited Streaks', 'Media/icons/check.png'),
                _buildFeatureItem(
                    'Unlimited cbt-games', 'Media/icons/check.png'),
                _buildFeatureItem('Get plus 5 hours\nPsychological session',
                    'Media/icons/check.png'),

                const Spacer(),

                // Buttons
                Padding(
                  padding: const EdgeInsets.only(bottom: 46),
                  child: Column(
                    children: [
                      _buildButton(
                        'EGP $price - $duration',
                        const Color(0xFFFFCA28),
                        onLifetimePurchase,
                      ),
                      const SizedBox(height: 20),
                      _buildButton(
                        'Go Plus Now',
                        Colors.transparent,
                        onGoPlusNow,
                        textColor: const Color(0xFFFFCA28),
                        borderColor: const Color(0xFFFFCA28),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text, String checkIcon) {
    return Padding(
      padding: const EdgeInsets.only(left: 51, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            checkIcon,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xB2000000),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color backgroundColor,
    VoidCallback? onTap, {
    Color textColor = Colors.white,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 292,
        height: 45,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Urbanist',
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}