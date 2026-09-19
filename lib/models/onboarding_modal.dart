class OnboardingModel {
  final String imagePath;
  final String title;
  final String? description;
  

  const OnboardingModel({
    required this.imagePath,
    required this.title,
    this.description,
  });

  static const List<OnboardingModel> onboardingList = [
    OnboardingModel(
      imagePath: "assets/images/Group.png",
      title: "Welcome To Islmi App",
      description: null,
    ),
    OnboardingModel(
      imagePath: "assets/images/kabba.png",
      title: "Welcome To Islami",
      description: "We Are Very Excited To Have You In Our Community",
    ),
    OnboardingModel(
      imagePath: "assets/images/welcome.png",
      title: "Reading the Quran",
      description: "Read, and your Lord is the Most Generous",
    ),
    OnboardingModel(
      imagePath: "assets/images/bearish.png",
      title: "Bearish",
      description: "Praise the name of your Lord, the Most High",
    ),
    OnboardingModel(
      imagePath: "assets/images/radio.png",
      title: "Holy Quran Radio",
      description:
          "You can listen to the Holy Quran Radio through the application for free and easily",
    ),
  ];
}
