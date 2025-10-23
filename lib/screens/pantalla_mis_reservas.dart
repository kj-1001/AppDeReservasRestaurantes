import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reserva.dart';
import '../providers/reserva_provider.dart';
import '../widgets/reserva_card.dart';

class PantallaMisReservas extends StatelessWidget {
  const PantallaMisReservas({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservaProvider>();

    // Filtrar solo reservas de tipo usuario (las creadas en el modal)
    final List<Reserva> misReservas =
        provider.reservas.where((r) => r.tipo == 'Restaurante').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: misReservas.isEmpty
          ? const Center(
              child: Text(
                'No has realizado reservas aún',
                style: TextStyle(color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: misReservas.length,
              itemBuilder: (_, index) {
                final reserva = misReservas[index];
                return ReservaCard(
                  reserva: reserva,
                  onFavoritoToggle: () => provider.toggleFavorito(reserva),
                );
              },
            ),
    );
  }
}
