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
        'imagePath': "https://cdn.discordapp.com/attachments/778499117277118470/1418453397585006735/rafan.png?ex=68ce2d2b&is=68ccdbab&hm=16f895cf3b81876210e4c0d8e81b53c0003df04c4bd876bf85297ff4d6dbb128& ",
      },
      {
        'nama': "Rakha Noor A. Admaja",
        'kelas': "XII PPLG 1",
        'absen': "32",
        'gmail': "rakhanoor12@gmail.com",
        'imagePath': "https://cdn.discordapp.com/attachments/778499117277118470/1418453397941518337/rakha.png?ex=68ce2d2b&is=68ccdbab&hm=37819eb71c4b5ac742f008633fcde410554d2b3ad7193f8805bae1f3e0897f43& ",
      },
      {
        'nama': "Daffa Ramadhan",
        'kelas': "XII PPLG 1",
        'absen': "09",
        'gmail': "daffa.bintang@gmail.com",
        'imagePath': "https://cdn.discordapp.com/attachments/778499117277118470/1418453398285582366/daffa.jpg?ex=68ce2d2b&is=68ccdbab&hm=ef3d4badf64fc261cdb86b0635bd8201a3add9f95d1d208e79a1279e7a390a9d&",
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