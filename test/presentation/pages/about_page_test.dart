import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  Widget _makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('should has everything we need', (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(find.byType(Image), findsOneWidget);
    expect(
        find.text(
            'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.'),
        findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
}
