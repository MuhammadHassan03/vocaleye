import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String cameraIcon = '''
<svg viewBox="0 0 24 24">
  <path fill="black" d="M12 5c-3.86 0-7 3.14-7 7s3.14 7 7 7
  7-3.14 7-7-3.14-7-7-7zm0 12c-2.76 0-5-2.24-5-5s2.24-5
  5-5 5 2.24 5 5-2.24 5-5 5zm8-14h-3.17l-1.84-2H8.01L6.17
  3H3c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h18c1.1 0 2-.9
  2-2V5c0-1.1-.9-2-2-2z"/>
</svg>
''';

class ViewAccountScreen extends StatefulWidget {
  const ViewAccountScreen({Key? key}) : super(key: key);

  @override
  _ViewAccountScreenState createState() => _ViewAccountScreenState();
}

class _ViewAccountScreenState extends State<ViewAccountScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _user;
  String? _error;


  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  Future<void> fetchUserData() async {
    // final prefs = await SharedPreferences.getInstance();
    // final userId = prefs.getString('userId') ?? '';
    //
    // if (userId.isEmpty) {
    //   setState(() {
    //     _isLoading = false;
    //     _error = 'User ID not found in preferences.';
    //   });
    //   return;
    // }
    //
    // final url = Uri.parse('https://skyride.onrender.com/api/getaccount/$userId');
    //
    // try {
    //   final response = await http.get(url);
    //
    //   if (response.statusCode == 200) {
    //     final jsonData = jsonDecode(response.body);
    //     if (jsonData['success'] == true) {
    //       setState(() {
    //         _user = jsonData['data'];
    //         _isLoading = false;
    //         _error = null;
    //       });
    //     } else {
    //       throw Exception('User data not found.');
    //     }
    //   } else {
    //     throw Exception('Server error: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   setState(() {
    //     _isLoading = false;
    //     _error = e.toString();
    //   });
    // }
  }

  Widget buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = _user?['image'];

    return Scaffold(
      appBar: AppBar(
        title: Text(_user?['username'] ?? 'Account'),
        backgroundColor: Color(0xFF0068CB),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Container(
        color: Colors.red[100],
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text(
          'Error: $_error',
          style: TextStyle(color: Colors.red[800], fontSize: 16),
          textAlign: TextAlign.center,
        ),
      )
          : _user == null
          ? Center(child: Text('No user data found.'))
          : ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: ProfilePic(
              imageUrl: (profileImage != null && profileImage.isNotEmpty)
                  ? profileImage
                  : null,
            ),
          ),
          SizedBox(height: 20),
          buildStyledInfoTile('Username', _user!['username'] ?? ''),
          buildStyledInfoTile('Email', _user!['email'] ?? ''),
          buildStyledInfoTile('Phone', _user!['phone'].toString()),
          buildStyledInfoTile('Date of Birth', (_user!['date_of_birth'] ?? '').split('T')[0]),
          buildStyledInfoTile('Country', _user!['country'] ?? ''),
          buildStyledInfoTile('Role', _user!['role'] ?? ''),
        ],
      ),
    );
  }

}

Widget buildStyledInfoTile(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}



class ProfilePic extends StatelessWidget {
  final String? imageUrl;

  const ProfilePic({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl!)
                : AssetImage("assets/images/user1.jpg") as ImageProvider,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 36,
              width: 36,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  // Future: open image picker or camera
                },
                child: SvgPicture.string(cameraIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}
