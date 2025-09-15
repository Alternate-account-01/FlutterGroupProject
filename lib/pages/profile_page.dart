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
            nama: "Daffa Ramadhan",
            kelas: "XII PPLG 1",
            absen: "09",
            gmail: "daffa.bintang@gmail.com",
            imagePath: "images/epic.jpg",
          ),
          SizedBox(height: 16),
          ProfileCard(
            nama: "Rafan Eka Dinata",
            kelas: "XII PPLG 1",
            absen: "30",
            gmail: "rafaneka@gmail.com",
            imagePath: "https://cdn.discordapp.com/attachments/1417108311622549535/1417108534830563448/WhatsApp_Image_2025-08-30_at_11.22.05_0957ef8f.jpg?ex=68c948ab&is=68c7f72b&hm=1bbd3a495066ba7f628884f8bb38ff09ac29d61df4c05a9478ea510fd47addf8",
          ),
          SizedBox(height: 16),
          ProfileCard(
            nama: "Rakha Noor A. Admaja",
            kelas: "XII PPLG 1",
            absen: "32",
            gmail: "rakhanoor12@gmail.com",
            imagePath: "https://cdn.discordapp.com/attachments/1417108311622549535/1417109670639964160/livereactionadmin.png?ex=68c949ba&is=68c7f83a&hm=e809139de1aff33f9105770b7323fca01e29dff2151f259a7f17f4c1f7857615",
          ),
        ],
      ),
    );
  }
}
