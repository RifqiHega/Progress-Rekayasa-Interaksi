import 'package:flutter/material.dart';

// Definisi enum untuk mempermudah pengelolaan state Radio Button
enum PrintColor { color, blackWhite }
enum PageSelection { all, custom }

class CetakDokumenPage extends StatefulWidget {
  const CetakDokumenPage({super.key});

  @override
  State<CetakDokumenPage> createState() => _CetakDokumenPageState();
}

class _CetakDokumenPageState extends State<CetakDokumenPage> {
  // State untuk Dropdown Pilihan Kertas
  String? _selectedUkuran = 'A4 (21 x 29.7 cm)';
  final List<String> _ukuranOptions = ['A4 (21 x 29.7 cm)', 'F4/Folio (21.5 x 33 cm)', 'A3 (29.7 x 42 cm)'];

  // State untuk Dropdown Jenis Kertas
  String? _selectedJenis = 'HVS 80 gsm';
  final List<String> _jenisOptions = ['HVS 80 gsm', 'HVS 100 gsm', 'Art Paper', 'Karton'];

  // State untuk Radio Button Warna
  PrintColor _printColor = PrintColor.color;

  // State untuk Radio Button Halaman
  PageSelection _pageSelection = PageSelection.all;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF7E5EFF);
    
    // Warna untuk Upload Button
    final Color uploadBgColor = const Color(0xFF0009FF).withOpacity(0.15); // 0009FF dengan opacity 15%
    const Color uploadIconColor = Color(0xFF5E00FF);
    final Color uploadTextColor = Colors.grey[600]!;

    return Scaffold(
      // 1. APP BAR
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // Matikan default back button
        title: const Text(
          "FOTOCOPY BAROKAH",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Icon Back di kiri atas (Leading)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADING: CETAK DOKUMEN
            const Text(
              "CETAK DOKUMEN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),

            // 2. TOMBOL UPLOAD FILE
            InkWell(
              onTap: () {
                // TODO: Implementasi logika pilih file
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Membuka dialog pilih file...")),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: uploadBgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: uploadIconColor, width: 1.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 60,
                      color: uploadIconColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Upload your file here",
                      style: TextStyle(
                        color: uploadTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),

            // KOTAK BESAR UNTUK DETAIL CETAK
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADING: Detail Cetak
                  const Text(
                    "Detail Cetak",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(height: 30, thickness: 1),

                  // 1. UKURAN KERTAS (Dropdown)
                  _buildDetailSection(
                    context,
                    label: "Ukuran",
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedUkuran,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      items: _ukuranOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUkuran = newValue;
                        });
                      },
                    ),
                  ),

                  // 2. JENIS KERTAS (Dropdown)
                  _buildDetailSection(
                    context,
                    label: "Jenis Kertas",
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedJenis,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      items: _jenisOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedJenis = newValue;
                        });
                      },
                    ),
                  ),
                  
                  // 3. WARNA (Radio Button)
                  _buildDetailSection(
                    context,
                    label: "Warna",
                    child: Row(
                      children: [
                        _buildRadioButton(
                          title: "Berwarna",
                          value: PrintColor.color,
                          groupValue: _printColor,
                          onChanged: (value) => setState(() => _printColor = value!),
                        ),
                        _buildRadioButton(
                          title: "Hitam Putih",
                          value: PrintColor.blackWhite,
                          groupValue: _printColor,
                          onChanged: (value) => setState(() => _printColor = value!),
                        ),
                      ],
                    ),
                  ),

                  // 4. PAGES (Radio Button + Input Text)
                  _buildDetailSection(
                    context,
                    label: "Halaman",
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildRadioButton(
                          title: "Semua Halaman",
                          value: PageSelection.all,
                          groupValue: _pageSelection,
                          onChanged: (value) => setState(() => _pageSelection = value!),
                        ),
                        // Input untuk halaman kustom
                        Row(
                          children: [
                            Radio<PageSelection>(
                              value: PageSelection.custom,
                              groupValue: _pageSelection,
                              onChanged: (value) => setState(() => _pageSelection = value!),
                            ),
                            const Text("Kustom:"),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                readOnly: _pageSelection == PageSelection.all,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: '1, 3-5...',
                                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  filled: _pageSelection == PageSelection.all,
                                  fillColor: _pageSelection == PageSelection.all ? Colors.grey[200] : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 5. CATATAN TAMBAHAN (Text Box Besar)
                  _buildDetailSection(
                    context,
                    label: "Catatan Tambahan",
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Misalnya: Cetak bolak-balik, atau laminasi glossy',
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        contentPadding: const EdgeInsets.all(10),
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk membuat setiap bagian detail
  Widget _buildDetailSection(BuildContext context, {required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // Helper widget untuk membuat Radio Button dengan label
  Widget _buildRadioButton<T>({
    required String title,
    required T value,
    required T groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: const Color(0xFF7E5EFF),
          ),
          Text(title),
        ],
      ),
    );
  }
}