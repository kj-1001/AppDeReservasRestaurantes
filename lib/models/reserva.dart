class Reserva {
  final String nombre;     // Nombre o descripción del restaurante
  final String tipo;       // Tipo de reserva: "Hotel" o "Restaurante"
  final DateTime fecha;    // Fecha de la reserva
  final String imagen;     // 🔹 URL de la imagen
  final bool esFavorito;   // 🔹 Indica si está en favoritos

  Reserva({
    required this.nombre,
    required this.tipo,
    required this.fecha,
    required this.imagen,
    this.esFavorito = false,
  });

  // 🔹 Método útil para modificar una propiedad sin recrear todo
  Reserva copyWith({
    String? nombre,
    String? tipo,
    DateTime? fecha,
    String? imagen,
    bool? esFavorito,
  }) {
    return Reserva(
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
      imagen: imagen ?? this.imagen,
      esFavorito: esFavorito ?? this.esFavorito,
    );
  }
}
