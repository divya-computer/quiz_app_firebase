class Questions {
  final String id;
  final String title;
  final Map<String, bool> options;

//This is Constructor
  Questions({required this.id, required this.title, required this.options});

  @override
  String toString() {
    return 'Questions (Id : $id , title : $title , options : $options)';
  }
}
