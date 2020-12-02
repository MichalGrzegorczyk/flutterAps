class Entry {
  final int id;
  final String word;
  final String definition;
  final int imageId;
  final String language;

  Entry({this.id, this.word, this.definition, this.imageId, this.language});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'definition': definition,
      'imageId': imageId,
      'language': language
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'word': word,
      'definition': definition,
      'imageId': imageId,
      'language': language
    };
  }

  static Entry fromMap(Map<String, dynamic> map) {
    return new Entry(
        id: map['id'],
        word: map['word'],
        definition: map['definition'],
        imageId: map['imageId'],
        language: map['language']);
  }
}
