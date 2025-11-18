import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisikan warna utama berdasarkan kode #7E5EFF
    const Color primaryColor = Color(0xFF7E5EFF);

    return MaterialApp(
      title: 'Fotocopy Barokah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        // Optional: Definisikan warna tombol secara global
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // 10% round
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF7E5EFF);

    return Scaffold(
      body: Column(
        children: [
          // 1. BAGIAN ATAS (HEADER)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            color: primaryColor,
            child: const Center(
              child: Text(
                "FOTOCOPY BAROKAH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 2. BAGIAN TENGAH (DESKRIPSI & TOMBOL)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Deskripsi
                  const Text(
                    "Urusan cetak dokumen, foto, hingga undangan\nmenjadi lebih cepat dan hemat. Kami hadir\nsebagai solusi cetak digital terjangkau\nuntuk kebutuhan sekolah, perkantoran,\ndan masyarakat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 1.5, // Menambah jarak antar baris
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Siap Melayani",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      height: 1.5, // Menambah jarak antar baris
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 3 Tombol Besar
                  _buildServiceButton(
                    context,
                    icon: Icons.description,
                    label: "Cetak Dokumen",
                  ),
                  const SizedBox(height: 15),
                  _buildServiceButton(
                    context,
                    icon: Icons.photo,
                    label: "Cetak Foto",
                  ),
                  const SizedBox(height: 15),
                  _buildServiceButton(
                    context,
                    icon: Icons.mail,
                    label: "Cetak Undangan",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. BAGIAN BAWAH (NAVBAR)
      bottomNavigationBar: Container(
        height: 70, // Tinggi navbar
        color: primaryColor,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarItem(icon: Icons.home, label: "Home", isSelected: true),
            _NavBarItem(icon: Icons.history, label: "Riwayat Pesanan"),
            _NavBarItem(icon: Icons.person, label: "Profile"),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk membuat tombol layanan
  Widget _buildServiceButton(BuildContext context, {required IconData icon, required String label}) {
    return ElevatedButton.icon(
      onPressed: () {
        // Logika saat tombol ditekan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label ditekan!')),
        );
      },
      icon: Icon(icon, size: 30),
      label: Text(label),
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 70)), // Memastikan tombol besar
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
      ),
    );
  }
}

// Helper Widget untuk item Navbar
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isSelected ? Colors.amberAccent : Colors.white; // Beri sedikit highlight
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 24),
        Text(
          label,
          style: TextStyle(
            color: iconColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}