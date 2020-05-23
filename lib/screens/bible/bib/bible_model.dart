class BibleModel {
  String book;
  List<Chapters> chapters;

  BibleModel({this.book, this.chapters});

  BibleModel.fromJson(Map<String, dynamic> json) {
    book = json['book'];
    if (json['chapters'] != null) {
      chapters = new List<Chapters>();
      json['chapters'].forEach((v) {
        chapters.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book'] = this.book;
    if (this.chapters != null) {
      data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  String chapter;
  List<Verses> verses;

  Chapters({this.chapter, this.verses});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'];
    if (json['verses'] != null) {
      verses = new List<Verses>();
      json['verses'].forEach((v) {
        verses.add(new Verses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter'] = this.chapter;
    if (this.verses != null) {
      data['verses'] = this.verses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Verses {
  String verse;
  String text;

  Verses({this.verse, this.text});

  Verses.fromJson(Map<String, dynamic> json) {
    verse = json['verse'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verse'] = this.verse;
    data['text'] = this.text;
    return data;
  }
}
