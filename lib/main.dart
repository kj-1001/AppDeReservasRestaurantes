import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/reserva_provider.dart';
import 'screens/pantalla_inicio.dart';

// Punto de entrada de la aplicación
void main() {
  runApp(
    MultiProvider(
      // Registro de los providers para gestión de estado global
      providers: [
        ChangeNotifierProvider(create: (_) => ReservaProvider()), // Provider de reservas
      ],
      child: const MiApp(),
    ),
  );
}

// Widget principal de la app
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Reservas', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principal de la app
      ),
      home: const PantallaInicio(), // Pantalla de inicio al abrir la app
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
    );
  }
}
