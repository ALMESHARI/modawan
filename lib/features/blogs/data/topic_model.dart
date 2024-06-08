class TopicModel {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final bool isVerified;
  final String creatorId;

  TopicModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.isVerified,
    required this.creatorId,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image'],
      isVerified: json['is_verified'],
      creatorId: json['creator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': imageUrl,
      'is_verified': isVerified,
      'creator': creatorId,
    };
  }
}
