import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
  final profiles = [  
      {
        'nama': "Rafan Eka Dinata",
        'kelas': "XII PPLG 1",
        'absen': "30",
        'gmail': "dinata.rafan@gmail.com",
        'imagePath': "https://cdn.discordapp.com/attachments/1417108311622549535/1417108534830563448/WhatsApp_Image_2025-08-30_at_11.22.05_0957ef8f.jpg?ex=68c948ab&is=68c7f72b&hm=1bbd3a495066ba7f628884f8bb38ff09ac29d61df4c05a9478ea510fd47addf8",
      },
      {
        'nama': "Rakha Noor A. Admaja",
        'kelas': "XII PPLG 1",
        'absen': "32",
        'gmail': "rakhanoor12@gmail.com",
        'imagePath': "https://cdn.discordapp.com/attachments/1417108311622549535/1417109670639964160/livereactionadmin.png?ex=68c949ba&is=68c7f83a&hm=e809139de1aff33f9105770b7323fca01e29dff2151f259a7f17f4c1f7857615",
      },
      {
        'nama': "Daffa Ramadhan",
        'kelas': "XII PPLG 1",
        'absen': "09",
        'gmail': "daffa.bintang@gmail.com",
        'imagePath': "https://cdn.discordapp.com/attachments/1308640731912601600/1417356463583793202/daffa.jpg?ex=68ca2f92&is=68c8de12&hm=588da967a5e9fae5da4606c3997ae616fb0fc41ed73e5d506904c64425d91cb4&",
      }
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: AnimationLimiter(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 84),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final profile = profiles[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: ProfileCard(
                              nama: profile['nama']!,
                              kelas: profile['kelas']!,
                              absen: profile['absen']!,
                              gmail: profile['gmail']!,
                              imagePath: profile['imagePath']!,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: profiles.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}