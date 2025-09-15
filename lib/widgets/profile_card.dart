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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(imagePath),//yow, Galih here, i don fucking know what batshit happens to your yaml or anything, but i tried network image and it works
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          // Menggunakan widget _InfoRow yang ada di file yang sama
          _InfoRow(icon: Icons.school_outlined, text: kelas),
          const SizedBox(height: 12),
          _InfoRow(
              icon: Icons.format_list_numbered_rounded,
              text: "Absen No. $absen"),
          const SizedBox(height: 12),
          _InfoRow(icon: Icons.email_outlined, text: gmail),
        ],
      ),
    );
  }
}

// Widget _InfoRow tetap private karena hanya digunakan oleh ProfileCard.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 22),
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