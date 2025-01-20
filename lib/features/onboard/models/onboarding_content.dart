class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<OnboardingContent> onboardingContents = [
  OnboardingContent(
    title: 'Wellness Tailored to You',
    description: 'Set your goals and let Purify guide you with yoga, remedies, and lifestyle tips.',
    image: 'assets/images/onboard1.svg',
  ),
  OnboardingContent(
    title: 'Master Yoga, One Pose at a Time',
    description: 'Learn, practice, and progress with guided yoga sessions designed for all levels.',
    image: 'assets/images/onboard2.svg',
  ),
  OnboardingContent(
    title: 'Natural Remedies for Wellness',
    description: 'Discover organic supplements and ancient Ayurvedic care tailored for you.',
    image: 'assets/images/onboard3.svg',
  ),
  OnboardingContent(
    title: 'Let\'s Create Your Personalized Wellness Plan!',
    description: 'Answer a few quick questions to help us tailor the perfect plan for your health goals.',
    image: 'assets/images/onboard4.svg',
  ),
]; 