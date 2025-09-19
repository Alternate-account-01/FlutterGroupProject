import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String kelas;
  final String absen;
  final String gmail;
  final String imagePath;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.kelas,
    required this.absen,
    required this.gmail,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
  
    const themeColor = Color(0xFF4285F4); 

    return Stack(
    
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        
        Container(
        
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                nama,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                kelas,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 20),
              _InfoRow(
                icon: Icons.format_list_numbered_rounded,
                text: "Absen No. $absen",
                iconColor: themeColor,
              ),
              const SizedBox(height: 16),
              _InfoRow(
                icon: Icons.email_outlined,
                text: gmail,
                iconColor: themeColor,
              ),
            ],
          ),
        ),
        
        Positioned(
          top: 0,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: NetworkImage(imagePath),
              onBackgroundImageError: (exception, stackTrace) {
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const _InfoRow({
    required this.icon,
    required this.text,
    this.iconColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}