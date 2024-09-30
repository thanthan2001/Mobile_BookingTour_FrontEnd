class CalculatorUtils {
  static List<String> calculateBMI(
      int weight, int height, int age, String gender) {
    double bmi;
    String result;

    // Chuyển đổi chiều cao từ cm thành m
    double heightInMeter = height / 100;

    // Tính chỉ số BMI
    bmi = weight / (heightInMeter * heightInMeter);
    if (bmi < 18.5) {
      result = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      result = "Normal weight";
    } else if (bmi >= 24.9 && bmi < 29.9) {
      result = "Overweight";
    } else if (bmi >= 29.9 && bmi < 34.9) {
      result = "Obesity (Class 1)";
    } else if (bmi >= 34.9 && bmi < 39.9) {
      result = "Obesity (Class 2)";
    } else {
      result = "Obesity (Class 3)";
    }
    return [" ${bmi.toStringAsFixed(2)}", result];
  }

  static List<double> calculateHealthyWeight(int height) {
    double heightInCM = height - 100;
    double idealWeight = (heightInCM * 9) / 10; // Cân nặng lý tưởng
    double maxWeight = heightInCM; // Mức cân tối đa
    double minWeight = (heightInCM * 8) / 10; // Mức cân tối thiểu
    return [idealWeight, maxWeight, minWeight];
  }

  static double calculateDailyWaterIntake(int weightInKg) {
    const double waterIntakePerKg = 0.03;
    // Tính toán lượng nước uống dựa trên cân nặng
    double waterIntake = weightInKg * waterIntakePerKg;
    return waterIntake;
  }

  static const Map<String, double> metValues = {
    'resting': 1.2, // Nghỉ ngơi
    'sedentary': 1.375, // Hoạt động ít hoặc không
    'light': 1.55, // Hoạt động nhẹ
    'moderate': 1.725, // Hoạt động vừa phải
    'vigorous': 1.9, // Hoạt động mạnh
  };
  static double calculateDailyEnergyIntake({
    required double weightInKg,
    required double heightInCm,
    required int age,
    required String gender,
    required double activityLevel,
  }) {
    // Tính toán năng lượng cơ bản (BMR - Basal Metabolic Rate) dựa trên giới tính
    double bmr;
    if (gender.toLowerCase() == 'male') {
      bmr =
          (13.397 * weightInKg) + (4.799 * heightInCm) - (5.677 * age) + 88.362;
    } else {
      bmr =
          (9.247 * weightInKg) + (3.098 * heightInCm) - (4.330 * age) + 447.593;
    }

    // Tính toán năng lượng cần nạp vào trong một ngày dựa trên chỉ số BMI và hoạt động
    double energyIntake = bmr * activityLevel;

    return energyIntake;
  }

  static double calculateWaterPercentage(
      {required int consumedWater, required double targetWater}) {
    if (targetWater <= 0) {
      return 0.0; // Tránh chia cho 0
    }
    double percentage = (consumedWater / targetWater) * 100;
    return percentage > 100
        ? 100
        : percentage; // Giới hạn phần trăm tối đa là 100%
  }

  static double phanTramTieuThu(
      {required int consumed, required double target}) {
    if (target <= 0) {
      return 0.0; // Tránh chia cho 0
    }
    double percentage = (target / consumed) * 100;
    return percentage > 100
        ? 100
        : percentage; // Giới hạn phần trăm tối đa là 100%
  }

  static double phanTramConLai(
      {required int consumed, required double target}) {
    if (target <= 0) {
      return 0.0; // Tránh chia cho 0
    }
    double percentage = 100 - (target / consumed) * 100;
    return percentage; // Giới hạn phần trăm tối đa là 100%
  }

  static double soDaTieuThu({required double total, required double percent}) {
    double tieuThu = (percent / 100) * total;
    return tieuThu <  0 ? 0 : tieuThu;
  }
}
