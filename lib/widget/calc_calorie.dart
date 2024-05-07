import 'package:bmicalc/widget/gender.dart';

enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extraActive
}

double calculateBMR(double weight, double height, int age, Gender gender) {
  if (gender == Gender.male) {
    return (10 * weight) + (6.25 * height) - (5 * age) + 5;
  } else {
    return (10 * weight) + (6.25 * height) - (5 * age) - 161;
  }
}

double calculateDailyCalories(double bmr, ActivityLevel activityLevel) {
  switch (activityLevel) {
    case ActivityLevel.sedentary:
      return bmr * 1.2;
    case ActivityLevel.lightlyActive:
      return bmr * 1.375;
    case ActivityLevel.moderatelyActive:
      return bmr * 1.55;
    case ActivityLevel.veryActive:
      return bmr * 1.725;
    case ActivityLevel.extraActive:
      return bmr * 1.9;
    default:
      return bmr * 1.2;
  }
}
