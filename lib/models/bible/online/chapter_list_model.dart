class ChapterList {
  List<Data> data;

  ChapterList({this.data});

  ChapterList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String bibleId;
  String bookId;
  String number;
  String reference;

  Data({this.id, this.bibleId, this.bookId, this.number, this.reference});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bibleId = json['bibleId'];
    bookId = json['bookId'];
    number = json['number'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bibleId'] = this.bibleId;
    data['bookId'] = this.bookId;
    data['number'] = this.number;
    data['reference'] = this.reference;
    return data;
  }
}
