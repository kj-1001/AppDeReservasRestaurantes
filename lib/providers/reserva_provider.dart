import 'package:flutter/material.dart';
import '../models/reserva.dart';

class ReservaProvider with ChangeNotifier {
  List<Reserva> _reservas = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Reserva> get reservas => List.unmodifiable(_reservas);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 🔹 Cargar reservas de prueba con imágenes aleatorias (Lorem Picsum)
  Future<void> cargarReservas() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Generar 10 reservas de ejemplo con imágenes aleatorias
      _reservas = List.generate(10, (index) {
        return Reserva(
          nombre: 'Restaurante ${index + 1}',
          tipo: 'Restaurante',
          fecha: DateTime.now().add(Duration(days: index + 1)),
          // Imagen aleatoria de Lorem Picsum
          imagen: 'https://picsum.photos/400/200?random=$index',
          esFavorito: false,
        );
      });
    } catch (e) {
      _errorMessage = 'Ocurrió un error: $e';
      _reservas = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 🔹 Agregar una nueva reserva
  Future<void> agregarReserva(Reserva reserva) async {
    _reservas.add(reserva);
    notifyListeners();
  }

  // 🔹 Marcar o desmarcar como favorito
  void toggleFavorito(Reserva reserva) {
    final index = _reservas.indexOf(reserva);
    if (index != -1) {
      _reservas[index] = _reservas[index].copyWith(
        esFavorito: !_reservas[index].esFavorito,
      );
      notifyListeners();
    }
  }

  // 🔹 Limpiar todas las reservas
  void limpiarReservas() {
    _reservas.clear();
    notifyListeners();
  }

  // 🔹 Obtener solo los favoritos
  List<Reserva> get reservasFavoritas =>
      _reservas.where((r) => r.esFavorito).toList();
}
