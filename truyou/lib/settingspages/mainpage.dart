import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Row(
            children: [
              Image(image: AssetImage("Media/icons/previous.png")),
              SizedBox(width: 10),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Setting',
                  style: TextStyle(
                    color: Color(0xFF393939),
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF393939)),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 0),
                    ProfileSection(),
                    const SizedBox(height: 10),
                    ShareButton(
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    ThemeColorOption(
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    AppLanguageOption(
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    NotificationSettingOption(
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    AboutOption(
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    ContactSupportOption(
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    ProblemReportOption(
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    UpgradeAd(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(
            width: 38,
            height: 38,
            image: AssetImage("Media/images/brain.png"),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TruYou',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFA259FF),
                ),
              ),
              const SizedBox(height: 0),
              const Text(
                'Your Mental Health'
                '\n'
                ' Assistant All Day !',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 6,
                  color: Color(0x6B000000),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 55,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFA259FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Ver 1.0',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFA259FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ShareButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFA259FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.share,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'Share App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeColorOption extends StatelessWidget {
  final Function()? onTap;
  final List<Color> themeColors;

  const ThemeColorOption({
    Key? key,
    this.onTap,
    this.themeColors = const [
      Color(0xFFFFE5E5),
      Color(0xFFE5FFF1),
      Color(0xFFE5E5E5),
      Color(0xFFA259FF),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.palette,
              size: 24,
              color: Color(0xFFA259FF),
            ),
            const SizedBox(width: 16),
            const Text(
              'Theme Color',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF393939),
              ),
            ),
            const Spacer(),
            Row(
              children: themeColors
                  .map((color) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: 21,
                          height: 21,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AppLanguageOption extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLanguageChange;
  final String currentLanguage;

  const AppLanguageOption({
    this.onTap,
    this.onLanguageChange,
    this.currentLanguage = 'En',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.language,
              size: 24,
              color: Color(0xFFA259FF),
            ),
            const SizedBox(width: 16),
            const Text(
              'App Language',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF393939),
              ),
            ),
            Spacer(),
            Container(
              height: 18,
              child: Row(
                children: [
                  _LanguageOption(
                    language: 'Ar',
                    isSelected: currentLanguage == 'Ar',
                    onTap: onLanguageChange,
                  ),
                  const SizedBox(width: 8),
                  _LanguageOption(
                    language: 'En',
                    isSelected: currentLanguage == 'En',
                    onTap: onLanguageChange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback? onTap;

  const _LanguageOption({
    required this.language,
    required this.isSelected,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 19,
        height: 18,
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 232, 232, 232)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            language,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFFA259FF),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationSettingOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showRightIcon;
  final double horizontalPadding;
  final double verticalPadding;

  const NotificationSettingOption({
    this.title = 'Notification Setting',
    this.icon = Icons.notifications_none,
    required this.onTap,
    this.showRightIcon = true,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.notifications_outlined,
              size: 24,
              color: Color(0xFFA259FF),
            ),
            SizedBox(width: 16),
            Text(
              'Notification Setting',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFA259FF),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutOption extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onInfoTap;

  const AboutOption({
    Key? key,
    this.onTap,
    this.onInfoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 24,
              color: Color(0xFFA259FF),
            ),
            SizedBox(width: 16),
            Text(
              'About TruYou',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF393939),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFA259FF),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSupportOption extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onInfoTap;

  const ContactSupportOption({
    Key? key,
    this.onTap,
    this.onInfoTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(
              Icons.support_agent_outlined,
              size: 24,
              color: Color(0xFFA259FF),
            ),
            SizedBox(width: 16),
            Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFA259FF),
            ),
          ],
        ),
      ),
    );
  }
}

class ProblemReportOption extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onSettingsTap;

  const ProblemReportOption({
    Key? key,
    this.onTap,
    this.onShareTap,
    this.onSettingsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(
              Icons.warning_amber,
              size: 24,
              color: Color(0xFFA259FF),
            ),
            SizedBox(width: 16),
            Text(
              'Problem Report',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFA259FF),
            ),
          ],
        ),
      ),
    );
  }
}

class UpgradeAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFCA28),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upgrade to',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF393939),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.flash_on, color: Color(0xFF393939), size: 16),
                  SizedBox(width: 4),
                  Text(
                    'TruYou Plus',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF393939),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                '• Ultimate experience\n• Remove ads',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 12,
                  color: Color(0xFF393939),
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            'DEMO AD',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF393939),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.play_arrow, color: Color(0xFF393939), size: 24),
        ],
      ),
    );
  }
}
