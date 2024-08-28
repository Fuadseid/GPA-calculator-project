import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/model/gpa_form.dart';

class GpaFormNotifier extends StateNotifier<List<GpaForm>> {
  GpaFormNotifier() : super(const []);

  void addForm(String title, String credit, String result) async {
    final newPlace = GpaForm(name: "", credit: "", result: "");

    state = [newPlace, ...state];
  }
}

final GpaFormProvider = StateNotifierProvider<GpaFormNotifier, List<GpaForm>>(
  (ref) => GpaFormNotifier(),
);
