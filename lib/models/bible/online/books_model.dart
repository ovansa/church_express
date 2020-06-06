class Books {
  List<Data> data;

  Books({this.data});

  Books.fromJson(Map<String, dynamic> json) {
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
  String abbreviation;
  String name;
  String nameLong;

  Data({this.id, this.bibleId, this.abbreviation, this.name, this.nameLong});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bibleId = json['bibleId'];
    abbreviation = json['abbreviation'];
    name = json['name'];
    nameLong = json['nameLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bibleId'] = this.bibleId;
    data['abbreviation'] = this.abbreviation;
    data['name'] = this.name;
    data['nameLong'] = this.nameLong;
    return data;
  }
}
