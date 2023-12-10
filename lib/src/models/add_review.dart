class AddReviewModel {
  String id;
  String name;
  String review;
  AddReviewModel({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['review'] = review;
    return data;
  }
}
