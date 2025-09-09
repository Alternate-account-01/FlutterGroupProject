import 'package:flutter/material.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Our Team Profile",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: const [

          ProfileCard(
            nama: "Daffa Bintang Ramadhan",
            kelas: "XII PPLG 1",
            absen: "09",
            gmail: "daffa.bintang@gmail.com",
            imagePath: "assets/images/daffa.png",
          ),
          SizedBox(height: 16),
          ProfileCard(
            nama: "Rafan Eka Dinata",
            kelas: "XII PPLG 1",
            absen: "30",
            gmail: "rafaneka@gmail.com",
            imagePath: "assets/images/raffan.png",
          ),
          SizedBox(height: 16),
          ProfileCard(
            nama: "Rakha Noor A. Admaja",
            kelas: "XII PPLG 1",
            absen: "32",
            gmail: "rakhanoor12@gmail.com",
            imagePath: "assets/images/rakhan.png",
          ),
        ],
      ),
    );
  }
}