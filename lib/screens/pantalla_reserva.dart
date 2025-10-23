import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reserva.dart';
import '../providers/reserva_provider.dart';
import '../widgets/reserva_card.dart';
import 'pantalla_favoritos.dart';
import 'modal_reserva.dart';
import 'pantalla_mis_reservas.dart'; // Importa la nueva pantalla

class PantallaReserva extends StatefulWidget {
  const PantallaReserva({super.key});

  @override
  State<PantallaReserva> createState() => _PantallaReservaState();
}

class _PantallaReservaState extends State<PantallaReserva> {
  @override
  void initState() {
    super.initState();
    context.read<ReservaProvider>().cargarReservas();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReservaProvider>();

    final List<Reserva> restaurantes =
        provider.reservas.where((r) => r.tipo == 'Restaurante').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas Restaurante'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PantallaFavoritos(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.list_alt, color: Colors.white),
            onPressed: () {
              // Abrir la pantalla de reservas hechas por usuarios
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PantallaMisReservas(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: restaurantes.isEmpty
            ? const Center(
                child: Text(
                  'No hay reservas de restaurantes',
                  style: TextStyle(color: Colors.black54),
                ),
              )
            : ListView.builder(
                itemCount: restaurantes.length,
                itemBuilder: (_, index) {
                  final reserva = restaurantes[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ModalReserva(reservaOriginal: reserva),
                      );
                    },
                    child: ReservaCard(
                      reserva: reserva,
                      onFavoritoToggle: () => provider.toggleFavorito(reserva),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
