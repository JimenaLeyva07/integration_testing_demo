import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_testing_demo/ui/pages/my_home_page.dart';

// import 'package:integration_testing_demo/main.dart' as app;

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('end-to-end test', () {
//     testWidgets('tap on the floating action button, verify counter',
//         (tester) async {
//       app.main();
//       await tester.pumpAndSettle();

//       // Verify the counter starts at 0.
//       expect(find.text('0'), findsOneWidget);

//       // Finds the floating action button to tap on.
//       final Finder fab = find.byTooltip('Increment');

//       // Emulate a tap on the floating action button.
//       await tester.tap(fab);

//       // Trigger a frame.
//       await tester.pumpAndSettle();

//       // Verify the counter increments by 1.
//       expect(find.text('1'), findsOneWidget);
//     });
//   });
// }

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test complete PexelsApi App Flow', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MyHomePage(),
    ));
    await widgetTester.pumpAndSettle();
    Future.delayed(const Duration(milliseconds: 10000));

    //Abrir la img en Fullscreen
    await widgetTester.tap(find.byKey(const Key('img_0')));
    await widgetTester.pumpAndSettle();
    Future.delayed(const Duration(milliseconds: 2000));

    //Regresar a HomePage
    await widgetTester.tap(find.byIcon(Icons.arrow_back));
    await widgetTester.pumpAndSettle();

    //Ir a SearchPage
    await widgetTester.tap(find.byType(FloatingActionButton));
    await widgetTester.pumpAndSettle();
    Future.delayed(const Duration(milliseconds: 2000));

    //Un assert para asegurarnos que estamos en la pagina correcta
    expect(find.byType(TextField), findsOneWidget);

    //realizamos busqueda
    await widgetTester.enterText(find.byType(TextField), 'happy');
    await widgetTester.tap(find.byKey(const ValueKey('searchPageSearchIcon')));
    Future.delayed(const Duration(milliseconds: 10000));
    await widgetTester.pumpAndSettle();

    //assertamos los resultados
    expect(find.byType(Image), findsWidgets);
    Future.delayed(const Duration(milliseconds: 2000));
  });
}
