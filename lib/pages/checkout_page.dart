// lib/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedPayment = 'Transfer Bank';

  final List<String> _paymentMethods = [
    'Transfer Bank',
    'QRIS',
    'COD (Bayar di Tempat)',
    'Kartu Kredit',
    'Dompet Digital',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _formatPrice(double price) {
    final str = price.toStringAsFixed(0);
    final result = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) result.write('.');
      result.write(str[i]);
    }
    return result.toString();
  }

  void _placeOrder(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cart = context.read<CartModel>();
      final totalPrice = cart.totalPrice;
      cart.clear();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                  child: const Icon(Icons.check_circle, color: Colors.green, size: 44),
                ),
                const SizedBox(height: 16),
                const Text('Pesanan Berhasil!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'Terima kasih, ${_nameController.text}!\nTotal pembayaran Rp ${_formatPrice(totalPrice)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, height: 1.5),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // close dialog
                      Navigator.of(context).pop(); // close checkout
                      Navigator.of(context).pop(); // close cart
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Kembali ke Toko', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('Checkout'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, _) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Order summary card
                _SectionCard(
                  title: 'Ringkasan Pesanan',
                  icon: Icons.receipt_long,
                  child: Column(
                    children: [
                      ...cart.itemsList.map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Text(item.product.emoji, style: const TextStyle(fontSize: 24)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      Text('x${item.quantity}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Rp ${_formatPrice(item.totalPrice)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                          )),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal', style: TextStyle(color: Colors.grey)),
                          Text('Rp ${_formatPrice(cart.totalPrice)}'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Ongkos Kirim', style: TextStyle(color: Colors.grey)),
                          Text('Rp ${_formatPrice(15000)}'),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(
                            'Rp ${_formatPrice(cart.totalPrice + 15000)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigo),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Customer info
                _SectionCard(
                  title: 'Data Penerima',
                  icon: Icons.person_outline,
                  child: Column(
                    children: [
                      _InputField(
                        controller: _nameController,
                        label: 'Nama Lengkap',
                        hint: 'Contoh: Budi Santoso',
                        icon: Icons.person,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Nama tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 12),
                      _InputField(
                        controller: _phoneController,
                        label: 'Nomor Telepon',
                        hint: 'Contoh: 08123456789',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Nomor telepon tidak boleh kosong';
                          if (v.length < 10) return 'Nomor telepon tidak valid';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      _InputField(
                        controller: _addressController,
                        label: 'Alamat Pengiriman',
                        hint: 'Jl. Contoh No. 1, Kota, Provinsi',
                        icon: Icons.location_on,
                        maxLines: 3,
                        validator: (v) => v == null || v.trim().isEmpty ? 'Alamat tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 12),
                      _InputField(
                        controller: _notesController,
                        label: 'Catatan (opsional)',
                        hint: 'Contoh: Titip di satpam',
                        icon: Icons.note_outlined,
                        maxLines: 2,
                        validator: null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Payment method
                _SectionCard(
                  title: 'Metode Pembayaran',
                  icon: Icons.payment,
                  child: Column(
                    children: _paymentMethods.map((method) {
                      return RadioListTile<String>(
                        title: Text(method, style: const TextStyle(fontSize: 14)),
                        value: method,
                        groupValue: _selectedPayment,
                        onChanged: (val) => setState(() => _selectedPayment = val!),
                        activeColor: Colors.indigo,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Place order button
                ElevatedButton.icon(
                  onPressed: () => _placeOrder(context),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Buat Pesanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _SectionCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.indigo, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.indigo, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}