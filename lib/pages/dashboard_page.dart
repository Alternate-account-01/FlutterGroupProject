import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final List<Map<String, String>> members = const [
    {
      "name": "Daffa Bintang Ramadhan",
      "kelas": "11 PPLG 1, 09",
      "email": "daffa.ramadhan@gmail.com",
      "img": "assets/images/daffa.jpg",
    },
    {
      "name": "Rakha",
      "kelas": "11 PPLG 1, 10",
      "email": "rakha@gmail.com",
      "img": "assets/images/rakha.jpg",
    },
    {
      "name": "Raffan",
      "kelas": "11 PPLG 1, 11",
      "email": "raffan@gmail.com",
      "img": "assets/images/raffan.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              "Team Members",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: members.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final member = members[index];
                  return MemberCard(
                    name: member['name']!,
                    kelas: member['kelas']!,
                    email: member['email']!,
                    imgAsset: member['img']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String name;
  final String kelas;
  final String email;
  final String imgAsset;

  const MemberCard({
    super.key,
    required this.name,
    required this.kelas,
    required this.email,
    required this.imgAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(imgAsset),
            backgroundColor: Colors.transparent, // biar gak ada warna default
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            kelas,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ],
      ),
    );
  }
}