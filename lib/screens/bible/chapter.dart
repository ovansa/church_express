class Chapter {
  Data data;
  Meta meta;

  Chapter({this.data, this.meta});

  Chapter.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String bibleId;
  String number;
  String bookId;
  String reference;
  String copyright;
  String content;
  Next next;
  Next previous;

  Data(
      {this.id,
        this.bibleId,
        this.number,
        this.bookId,
        this.reference,
        this.copyright,
        this.content,
        this.next,
        this.previous});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bibleId = json['bibleId'];
    number = json['number'];
    bookId = json['bookId'];
    reference = json['reference'];
    copyright = json['copyright'];
    content = json['content'];
    next = json['next'] != null ? new Next.fromJson(json['next']) : null;
    previous =
    json['previous'] != null ? new Next.fromJson(json['previous']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bibleId'] = this.bibleId;
    data['number'] = this.number;
    data['bookId'] = this.bookId;
    data['reference'] = this.reference;
    data['copyright'] = this.copyright;
    data['content'] = this.content;
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    if (this.previous != null) {
      data['previous'] = this.previous.toJson();
    }
    return data;
  }
}

class Next {
  String id;
  String number;
  String bookId;

  Next({this.id, this.number, this.bookId});

  Next.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    bookId = json['bookId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['bookId'] = this.bookId;
    return data;
  }
}

class Meta {
  String fums;
  String fumsId;
  String fumsJsInclude;
  String fumsJs;
  String fumsNoScript;

  Meta(
      {this.fums,
        this.fumsId,
        this.fumsJsInclude,
        this.fumsJs,
        this.fumsNoScript});

  Meta.fromJson(Map<String, dynamic> json) {
    fums = json['fums'];
    fumsId = json['fumsId'];
    fumsJsInclude = json['fumsJsInclude'];
    fumsJs = json['fumsJs'];
    fumsNoScript = json['fumsNoScript'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fums'] = this.fums;
    data['fumsId'] = this.fumsId;
    data['fumsJsInclude'] = this.fumsJsInclude;
    data['fumsJs'] = this.fumsJs;
    data['fumsNoScript'] = this.fumsNoScript;
    return data;
  }
}
