class NewsData {
  String? status;
  int? statusCode;
  String? version;
  String? lastModified;
  String? access;
  int? total;
  int? limit;
  int? offset;
  List<Data>? data;
   

  NewsData(
      {this.status,
      this.statusCode,
      this.version,
      this.lastModified,
      this.access,
      this.total=0,
      this.limit,
      this.offset,
      this.data});

  NewsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status-code'];
    version = json['version'];
    lastModified = json['last-modified'];
    access = json['access'];
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = new List.from(<Data>[],growable: true);
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status-code'] = this.statusCode;
    data['version'] = this.version;
    data['last-modified'] = this.lastModified;
    data['access'] = this.access;
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? summary;
  String? link;
  String? published;
  String? image;
  bool? isFav;
  Data(
      {this.id,
      this.title,
      this.summary,
      this.link,
      this.published,
      this.image,this.isFav});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    link = json['link'];
    published = json['published'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['link'] = this.link;
    data['published'] = this.published;
    data['image'] = this.image;
    return data;
  }
}