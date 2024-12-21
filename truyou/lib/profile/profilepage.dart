import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  String userId = "ucFlNscXu8R55jobaFGkEKEWvNn2"; // Replace with your userId

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          userData = userSnapshot.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateUserField(String fieldName, String newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({fieldName: newValue});
      setState(() {
        userData![fieldName] = newValue;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fieldName updated successfully')),
      );
    } catch (e) {
      print("Error updating $fieldName: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update $fieldName')),
      );
    }
  }

  void editField(String fieldName, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $fieldName'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: fieldName,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String newValue = controller.text.trim();
              // Add validation logic here
              if (newValue.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$fieldName cannot be empty')),
                );
              } else {
                updateUserField(fieldName, newValue);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.05),
                    ProfileHeader(
                      size: size,
                      userName: userData!['username'] ?? 'Name not available',
                    ),
                    SizedBox(height: size.height * 0.02),
                    ProfileInfoItem(
                      size: size,
                      icon: 'Media/icons/usersmall.png',
                      text: userData!['username'] ?? 'Name not available',
                      onEdit: () => editField('username', userData!['username']),
                    ),
                    ProfileInfoItem(
                      size: size,
                      icon: 'Media/icons/arroba 1.png',
                      text: userData!['email'] ?? 'Email not available',
                      isEditable: false, // Email is not editable
                    ),
                    ProfileInfoItem(
                      size: size,
                      icon: 'Media/icons/call 1.png',
                      text: userData!['phone'] ?? 'Phone not available',
                      onEdit: () => editField('phone', userData!['phone']),
                    ),
                    ProfileInfoItem(
                      size: size,
                      icon: 'Media/icons/padlock 1.png',
                      text: 'Change Password',
                      onEdit: () => editField('password', ''),
                    ),
                    SizedBox(height: size.height * 0.03),
                    UpgradeAd(size: size),
                    SizedBox(height: size.height * 0.03),
                    LogoutButton(
                      size: size,
                      onPressed: () {
                        print('Logout');
                      },
                    ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final Size size;
  final String userName;

  const ProfileHeader({Key? key, required this.size, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6),
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: size.width * 0.12,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('Media/icons/user.png'),
              ),
              CircleAvatar(
                radius: size.width * 0.04,
                backgroundColor: Colors.white,
                child: Icon(Icons.edit, color: const Color(0xFF8B5CF6)),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            userName,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.005),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Basic member',
              style: TextStyle(
                color: const Color(0xFF8B5CF6),
                fontSize: size.width * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final Size size;
  final String icon;
  final String text;
  final VoidCallback? onEdit;
  final bool isEditable; // New parameter to control editability

  const ProfileInfoItem({
    Key? key,
    required this.size,
    required this.icon,
    required this.text,
    this.onEdit,
    this.isEditable = true, // Defaults to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.03),
            child: Image.asset(
              icon,
              width: size.width * 0.06,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: const Color(0xFF393939),
              ),
            ),
          ),
          if (isEditable) // Show edit icon only if editable
            IconButton(
              icon: Icon(Icons.edit, color: const Color(0xFF8B5CF6)),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }
}

class UpgradeAd extends StatelessWidget {
  final Size size;

  const UpgradeAd({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Upgrade to TruYou Plus');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.width * 0.04),
        decoration: BoxDecoration(
          color: const Color(0xFFFFCA28),
          borderRadius: BorderRadius.circular(size.width * 0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.flash_on,
                    color: Colors.black, size: size.width * 0.06),
                SizedBox(width: size.width * 0.02),
                Text(
                  'TruYou Plus',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'Ultimate experience\nRemove ads',
              style: TextStyle(fontSize: size.width * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final Size size;
  final VoidCallback? onPressed;

  const LogoutButton({Key? key, required this.size, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: const Color(0xFF8B5CF6),
          borderRadius: BorderRadius.circular(size.width * 0.02),
        ),
        child: Center(
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
