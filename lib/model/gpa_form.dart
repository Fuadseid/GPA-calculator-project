class Grade {
  final String letter;
  final double points;

  Grade(this.letter, this.points);

  static double getGradePoint(String letter) {
    switch (letter.toUpperCase()) {
      case 'A':
        return 4.0;
      case 'A-':
        return 3.75;
      case 'B+':
        return 3.5;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.75;
      case 'C+':
        return 2.5;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.5;
      case 'D':
        return 1.0;
      case 'F':
        return 0.0;
      default:
        throw ArgumentError('Invalid grade: $letter');
    }
  }
}

class GpaForm {
  GpaForm({
    required this.name,
    required this.credit,
    required this.result,
  });

  final String name;
  final String credit;
  final String result;

  double get gradePoint => Grade.getGradePoint(result);
}


