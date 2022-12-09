import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets("Form From JSON ecample app test", (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(Checkbox), findsWidgets);

  });
}
