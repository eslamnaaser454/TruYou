import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truyou/Login-Sginup/ResetPasswordfromprofile.dart';
import 'package:truyou/Login-Sginup/Sign_in.dart';
import 'package:truyou/settingspages/trueyoupluspage.dart';


class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 
  Map<String, dynamic>? userData;
   // Replace with your userId
     late String email;

 
  @override
  void initState() {
 
    super.initState();
    _getUserEmail();
    fetchUserData();
   
  }
    void _getUserEmail() {
    final User user = FirebaseAuth.instance.currentUser!;
    email = user.email!;
    setState(() {}); // To trigger a rebuild if needed
  }
Future<void> fetchUserData() async {
  try {
 

    print("Fetching data for email: $email");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    print("Documents fetched: ${querySnapshot.docs.length}");
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      });
      print("User data: $userData");
    } else {
      print("No user found with the provided email.");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}Future<void> updateUserField(String fieldName, String newValue) async {
  try {
    // Rule 1: Validate phone number length
    if (fieldName == 'phone' && (newValue.length < 8 || newValue.length > 20)) {
      throw Exception('Phone is invalid');
    }
    
    bool _validatePhoneNumber(String phoneNumber) {
      final regex = RegExp(r'^[+]?[0-9]+$');
      return regex.hasMatch(phoneNumber) && phoneNumber.length >= 8;
    }

    if (fieldName == 'phone') {
      if (_validatePhoneNumber(newValue) == false) {
        throw Exception('Phone is invalid');
      }
    }

    // Rule 2: Check if phone number already exists in the database
    if (fieldName == 'phone') {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: newValue)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs.first['email'] != email) {
          throw Exception('Phone number is already in use.');
        }
      }
    }

    // Rule 3: Check if username already exists in the database
    if (fieldName == 'username') {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: newValue)
          .get();

      // If there is already a document with this username and it's not the current user's username
      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs.first['email'] != email) {
          throw Exception('Username is already in use.');
        }
      }
    }

    // Rule 4: Fetch the document by email and update the field
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      String docId = userSnapshot.docs.first.id;

      // Update the field in the document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .update({fieldName: newValue});

      setState(() {
        userData![fieldName] = newValue;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fieldName updated successfully')),
      );
    } else {
      throw Exception('No user found with the provided email.');
    }
  } catch (e) {
    print("Error updating $fieldName: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$fieldName is already exist')),
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
                      userName: userData!['name'] ?? 'Name not available',
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
                      onEdit: () => Navigator.push(context, _createPageRoute(ResetPassword_P(email:email))),
                    ),
                    SizedBox(height: size.height * 0.03),
                    UpgradeAd(size: size),
                    SizedBox(height: size.height * 0.03),
                    LogoutButton(
                      size: size,
                      onPressed: () {
                        
                       Navigator.push(context, _createPageRoute(LoginScreen()));
                      },
                    ),
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
    );
  }
   PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
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
         Navigator.push(context, _createPageRoute(TruYouPlusPage()));
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
  
  PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
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
