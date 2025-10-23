import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reserva_provider.dart';
import '../widgets/reserva_card.dart';

class PantallaFavoritos extends StatelessWidget {
  const PantallaFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservaProvider>();

    final favoritos = provider.reservasFavoritas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: favoritos.isEmpty
          ? const Center(
              child: Text(
                'No hay favoritos aún',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (_, index) {
                final reserva = favoritos[index];
                return ReservaCard(
                  reserva: reserva,
                  onFavoritoToggle: () {
                    provider.toggleFavorito(reserva);
                  },
                );
              },
            ),
    );
  }
}
