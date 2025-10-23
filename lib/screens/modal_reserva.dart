import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/reserva.dart';
import '../providers/reserva_provider.dart';

class ModalReserva extends StatefulWidget {
  final Reserva reservaOriginal;

  const ModalReserva({super.key, required this.reservaOriginal});

  @override
  State<ModalReserva> createState() => _ModalReservaState();
}

class _ModalReservaState extends State<ModalReserva> {
  final TextEditingController _nombreUsuarioController = TextEditingController();
  DateTime? _fechaSeleccionada;
  String _tipoMesa = 'Normal';

  String formatearFecha(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/'
           '${fecha.month.toString().padLeft(2, '0')}/'
           '${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReservaProvider>();

    return AlertDialog(
      title: Text('Reservar: ${widget.reservaOriginal.nombre}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nombreUsuarioController,
            decoration: const InputDecoration(
              labelText: 'Tu nombre',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  _fechaSeleccionada == null
                      ? 'Selecciona fecha'
                      : formatearFecha(_fechaSeleccionada!),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _fechaSeleccionada ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _fechaSeleccionada = picked;
                    });
                  }
                },
                child: const Text('Seleccionar fecha'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _tipoMesa,
            decoration: const InputDecoration(
              labelText: 'Tipo de mesa',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Normal', child: Text('Normal')),
              DropdownMenuItem(value: 'VIP', child: Text('VIP')),
              DropdownMenuItem(value: 'Exterior', child: Text('Exterior')),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _tipoMesa = val;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nombreUsuarioController.text.isEmpty || _fechaSeleccionada == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Complete todos los campos')),
              );
              return;
            }

            final nuevaReserva = Reserva(
              nombre: _nombreUsuarioController.text, // nombre del usuario que reserva
              tipo: 'Restaurante',
              fecha: _fechaSeleccionada!,
              imagen: widget.reservaOriginal.imagen,
            );

            provider.agregarReserva(nuevaReserva);
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Reserva creada')),
            );
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
