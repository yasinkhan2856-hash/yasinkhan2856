import 'package:flutter_test/flutter_test.dart';
import 'package:yasinkhan/app.dart';

void main() {
  testWidgets('portfolio renders primary content', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    // The portfolio has deliberate, continuously looping animations, so
    // pumpAndSettle would never complete. Advance through the entrance motion
    // with a bounded pump instead.
    await tester.pump(const Duration(seconds: 3));
    expect(find.textContaining('YASIN KHAN'), findsWidgets);
    expect(find.text('View My Work'), findsOneWidget);
  });
}
