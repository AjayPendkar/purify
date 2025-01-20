class AsanaModel {
  final String asanaName;
  final String sanskritName;
  final String pronunciation;
  final String englishTranslation;
  final String category;
  final String primaryFocus;
  final String difficultyLevel;
  final String muscleGroupsWorked;
  final String bodyPartsAffected;
  final String commonMistakes;
  final String preparationPoses;
  final String followUpPoses;
  final String benefits;
  final String problemsSolved;
  final String contraindications;
  final String modifications;
  final String advancedVariations;
  final String breathingTechnique;
  final String duration;
  final String repeats;
  final String instructions;
  final String precautions;
  final String photoLink;
  final String videoLink;
  final String audioLink;
  final String history;
  final String chakrasActivated;
  final String element;
  final String mentalBenefits;
  final String spiritualSignificance;
  final String recommendedTimeOfDay;

  AsanaModel({
    required this.asanaName,
    required this.sanskritName,
    required this.pronunciation,
    required this.englishTranslation,
    required this.category,
    required this.primaryFocus,
    required this.difficultyLevel,
    required this.muscleGroupsWorked,
    required this.bodyPartsAffected,
    required this.commonMistakes,
    required this.preparationPoses,
    required this.followUpPoses,
    required this.benefits,
    required this.problemsSolved,
    required this.contraindications,
    required this.modifications,
    required this.advancedVariations,
    required this.breathingTechnique,
    required this.duration,
    required this.repeats,
    required this.instructions,
    required this.precautions,
    required this.photoLink,
    required this.videoLink,
    required this.audioLink,
    required this.history,
    required this.chakrasActivated,
    required this.element,
    required this.mentalBenefits,
    required this.spiritualSignificance,
    required this.recommendedTimeOfDay,
  });

  factory AsanaModel.fromJson(Map<String, dynamic> json) {
    return AsanaModel(
      asanaName: json['Asana Name'],
      sanskritName: json['Sanskrit Name'],
      pronunciation: json['Pronunciation'],
      englishTranslation: json['English Translation'],
      category: json['Category'],
      primaryFocus: json['Primary Focus'],
      difficultyLevel: json['Difficulty Level'],
      muscleGroupsWorked: json['Muscle Groups Worked'],
      bodyPartsAffected: json['Body Parts Affected'],
      commonMistakes: json['Common Mistakes'],
      preparationPoses: json['Preparation Poses'],
      followUpPoses: json['Follow-up Poses'],
      benefits: json['Benefits'],
      problemsSolved: json['Problems Solved'],
      contraindications: json['Contraindications'],
      modifications: json['Modifications'],
      advancedVariations: json['Advanced Variations'],
      breathingTechnique: json['Breathing Technique'],
      duration: json['Duration'],
      repeats: json['Repeats'],
      instructions: json['Instructions'],
      precautions: json['Precautions'],
      photoLink: json['Photo Link'],
      videoLink: json['Video Link'],
      audioLink: json['Audio Link'],
      history: json['History'],
      chakrasActivated: json['Chakras Activated'],
      element: json['Element'],
      mentalBenefits: json['Mental Benefits'],
      spiritualSignificance: json['Spiritual Significance'],
      recommendedTimeOfDay: json['Recommended Time of Day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Asana Name': asanaName,
      'Sanskrit Name': sanskritName,
      'Pronunciation': pronunciation,
      'English Translation': englishTranslation,
      'Category': category,
      'Primary Focus': primaryFocus,
      'Difficulty Level': difficultyLevel,
      'Muscle Groups Worked': muscleGroupsWorked,
      'Body Parts Affected': bodyPartsAffected,
      'Common Mistakes': commonMistakes,
      'Preparation Poses': preparationPoses,
      'Follow-up Poses': followUpPoses,
      'Benefits': benefits,
      'Problems Solved': problemsSolved,
      'Contraindications': contraindications,
      'Modifications': modifications,
      'Advanced Variations': advancedVariations,
      'Breathing Technique': breathingTechnique,
      'Duration': duration,
      'Repeats': repeats,
      'Instructions': instructions,
      'Precautions': precautions,
      'Photo Link': photoLink,
      'Video Link': videoLink,
      'Audio Link': audioLink,
      'History': history,
      'Chakras Activated': chakrasActivated,
      'Element': element,
      'Mental Benefits': mentalBenefits,
      'Spiritual Significance': spiritualSignificance,
      'Recommended Time of Day': recommendedTimeOfDay,
    };
  }
}
