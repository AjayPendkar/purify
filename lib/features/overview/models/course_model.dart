class CourseModel {
  final String imageUrl;
  final String title;
  final String instructor;
  final double progress;

  CourseModel({
    required this.imageUrl,
    required this.title,
    required this.instructor,
    required this.progress,
  });

  static List<CourseModel> sampleCourses = [
    CourseModel(
      imageUrl: 'assets/images/yoga1.jpg',
      title: 'Morning Flow Yoga for Beginners',
      instructor: 'Sarah Matthews',
      progress: 0.45,
    ),
    CourseModel(
      imageUrl: 'assets/images/yoga2.jpg',
      title: 'Power Vinyasa Flow',
      instructor: 'Michael Chen',
      progress: 0.30,
    ),
    CourseModel(
      imageUrl: 'assets/images/yoga1.jpg',
      title: 'Gentle Yoga for Flexibility',
      instructor: 'Emma Wilson',
      progress: 0.65,
    ),
    // Add more courses...
    CourseModel(
      imageUrl: 'assets/images/yoga2.jpg',
      title: 'Meditation and Mindfulness',
      instructor: 'David Kumar',
      progress: 0.20,
    ),
    // Add up to 15 courses with varied data
  ];
} 