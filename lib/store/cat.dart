class Cat {
  final String id;
  final List<String> tags;
  Cat({this.id, this.tags});

  // factory Cat.fromJson(Map<String, dynamic> json) {
  //   return Cat(
  //     id: json['id'] as String,
  //     tags: json['tags'] as List<String>,
  //   );
  // }
}
