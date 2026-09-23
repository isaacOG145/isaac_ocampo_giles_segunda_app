import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Asegúrate de usar el nombre correcto de tu paquete
import 'package:isaac_ocampo_giles_segunda_app/main.dart';

void main() {
  testWidgets('Prueba completa de la app Lista Viva', (WidgetTester tester) async {
    // 1. Cargar la aplicación
    await tester.pumpWidget(const MyApp());

    // 2. Verificar el estado inicial
    expect(find.text('Integrantes: 5'), findsOneWidget);
    expect(find.text('Total: 0'), findsOneWidget);
    expect(find.text('Alexa'), findsOneWidget);
    // Hay 5 tarjetas con "Puntos: 0"
    expect(find.text('Puntos: 0'), findsNWidgets(5));

    // 3. Probar la función _sumar (Sumar al primer integrante: Alexa)
    final sumarButtons = find.byTooltip('Sumar');
    await tester.tap(sumarButtons.first);
    await tester.pump();

    // Comprobar que solo 1 integrante tiene "Puntos: 1" y los demás (4) tienen "Puntos: 0"
    expect(find.text('Puntos: 1'), findsOneWidget);
    expect(find.text('Puntos: 0'), findsNWidgets(4));
    expect(find.text('Total: 1'), findsOneWidget);

    // 4. Probar la función _restar
    final restarButtons = find.byTooltip('Restar');
    await tester.tap(restarButtons.first);
    await tester.pump();

    // Todos vuelven a tener 0 puntos (5 widgets en total)
    expect(find.text('Puntos: 0'), findsNWidgets(5));
    expect(find.text('Total: 0'), findsOneWidget);

    // Comprobar que no baja a números negativos
    await tester.tap(restarButtons.first);
    await tester.pump();
    expect(find.text('Puntos: 0'), findsNWidgets(5));
    expect(find.text('Total: 0'), findsOneWidget);

    // 5. Probar la función _agregar
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Ahora hay 6 integrantes, todos con 0 puntos
    expect(find.text('Integrantes: 6'), findsOneWidget);
    expect(find.text('Integrante 6'), findsOneWidget);
    expect(find.text('Puntos: 0'), findsNWidgets(6));

    // 6. Probar la función _resetPuntos
    // Sumamos a los primeros dos integrantes
    await tester.tap(sumarButtons.first);
    await tester.tap(sumarButtons.at(1));
    await tester.pump();

    expect(find.text('Puntos: 1'), findsNWidgets(2));
    expect(find.text('Total: 2'), findsOneWidget);

    // Presionar el botón de reiniciar en el AppBar
    await tester.tap(find.byTooltip('Poner puntos en cero'));
    await tester.pump();

    // Los 6 integrantes vuelven a tener 0 puntos
    expect(find.text('Puntos: 0'), findsNWidgets(6));
    expect(find.text('Total: 0'), findsOneWidget);
  });
}