import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reserva.dart';
import '../providers/reserva_provider.dart';

class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  final VoidCallback? onFavoritoToggle; // 🔹 Callback opcional

  const ReservaCard({
    super.key,
    required this.reserva,
    this.onFavoritoToggle,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReservaProvider>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del restaurante/hotel
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              reserva.imagen,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              reserva.nombre,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${reserva.tipo} - ${reserva.fecha.day.toString().padLeft(2, '0')}/'
              '${reserva.fecha.month.toString().padLeft(2, '0')}/'
              '${reserva.fecha.year}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            trailing: IconButton(
              icon: Icon(
                reserva.esFavorito ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: onFavoritoToggle ??
                  () {
                    provider.toggleFavorito(reserva);
                  },
            ),
          ),
        ],
      ),
    );
  }
}
