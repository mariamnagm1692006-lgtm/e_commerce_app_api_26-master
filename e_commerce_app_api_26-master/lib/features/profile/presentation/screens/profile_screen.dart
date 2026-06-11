import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/profile_api/profile_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce_app_api_26/features/profile/data/profile_api/upload_api.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/upload_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> uploadProfileImage() async {
    /// استخدمنا باكدج ImagePicker
    /// عشان اقدر اختار صوره من ال gallery
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    try {
      /// ببعت الصوره الي اخترتها للفانكشن الي بتعمل upload للصوره
      UploadModel uploadModel = await UploadApi().uploadImage(image.path);

      setState(() {
        ///لما السيرفر ينجح انه يرفع الصوره مش بيبعت الصوره كا ملف ذي ما بعتهوله بيبعتلنا ال location بتاع الصوره بلمكان الي محفوظ فيها الصوره في السيرفرات علي الانترنت
        imageUrl = uploadModel.location;
      });
    } catch (e) {
      print("ERROR = $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  //////////////////////
  String? imageUrl;

  final ImagePicker picker = ImagePicker();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder<ProfileModel>(
        future: ProfileApi().getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          }
          ProfileModel? profileModel = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          ///لو رفعنا صوره جديده يستخدمها مرفعش يستخدم الي موجوده في الAPI لو مفيش اي صوره تعرض ال default الي موجوده
                          backgroundImage: NetworkImage(
                            imageUrl ??
                                profileModel?.avatar ??
                                "https://images.unsplash.com/photo-1554080353-a576cf803bda?q=80&w=1000",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileModel?.name ?? " ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            profileModel?.role ?? "",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        /////////////////
                        onPressed: uploadProfileImage,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      _buildSectionTitle('Account Settings'),
                      _buildProfileTile(
                        Icons.shopping_bag_outlined,
                        'My Orders',
                        'Track your orders',
                      ),
                      _buildProfileTile(
                        Icons.favorite_outline,
                        'Wishlist',
                        'Your favorite items',
                      ),
                      _buildProfileTile(
                        Icons.location_on_outlined,
                        'Shipping Address',
                        'Manage your addresses',
                      ),
                      _buildProfileTile(
                        Icons.payment_outlined,
                        'Payment Methods',
                        'Credit cards, wallets',
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('App Settings'),
                      _buildProfileTile(
                        Icons.notifications_none,
                        'Notifications',
                        'Control your alerts',
                      ),
                      _buildProfileTile(
                        Icons.lock_outline,
                        'Privacy',
                        'Manage your security',
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.red.withOpacity(0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 4),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {},
      ),
    );
  }
}
