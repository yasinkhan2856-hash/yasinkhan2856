import 'package:flutter_test/flutter_test.dart';
import 'package:yasinkhan/app.dart';

void main() {
  testWidgets('portfolio renders primary content', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('YASIN KHAN'), findsWidgets);
    expect(find.text('View My Work'), findsOneWidget);
  });
}
