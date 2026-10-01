import 'package:flutter/material.dart';

import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.username});

  final String username;

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: false),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: colorScheme.primaryContainer,
              child: Icon(Icons.person, size: 40, color: colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Text(
              'Username',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              username,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'views/login.dart';

// class ProfilePage extends StatelessWidget {
//   final String username;

//   const ProfilePage({super.key, required this.username});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 40,
//             child: Icon(Icons.person, size: 40),
//           ),
//           SizedBox(height: 15),
//           Text("Username", style: TextStyle(color: Colors.grey)),
//           SizedBox(height: 5),
//           Text(
//             username,
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           OutlinedButton.icon(
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//                 (route) => false,
//               );
//             },
//             icon: Icon(Icons.logout),
//             label: Text("Logout"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'views/login.dart';

// class ProfilePage extends StatefulWidget {
//   final String username;

//   const ProfilePage({super.key, required this.username});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Color warna = Colors.green; // menyimpan warna yang sedang dipilih

//   // Fungsi kecil untuk membuat 1 tombol warna
//   Widget tombolWarna(Color pilihan) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           warna = pilihan; // ganti warna, lalu layar digambar ulang
//         });
//       },
//       child: CircleAvatar(radius: 15, backgroundColor: pilihan),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundColor: warna, // <- pakai variabel
//             child: Icon(Icons.person, size: 40, color: Colors.white),
//           ),
//           SizedBox(height: 15),
//           Text(
//             widget.username, // <- pakai widget.
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),

//           // 3 tombol warna: biru, merah, ungu
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               tombolWarna(Colors.blue),
//               SizedBox(width: 10),
//               tombolWarna(Colors.red),
//               SizedBox(width: 10),
//               tombolWarna(Colors.purple),
//             ],
//           ),
//           SizedBox(height: 20),

//           ElevatedButton.icon(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: warna, // <- warna logout ikut berubah
//               foregroundColor: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//                 (route) => false,
//               );
//             },
//             icon: Icon(Icons.logout),
//             label: Text("Logout"),
//           ),
//         ],
//       ),
//     );
//   }
// }