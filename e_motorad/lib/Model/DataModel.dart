class Ride {
  String? guid;
  String? link;
  String? pubDate;
  String? source;
  String? title;
  Ride({this.guid, this.link, this.pubDate, this.source, this.title});
  Ride.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    link = json['link'];
    pubDate = json['pubDate'];
    source = json['source'];
    title = json['title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    data['link'] = this.link;
    data['pubDate'] = this.pubDate;
    data['source'] = this.source;
    data['title'] = this.title;
    return data;
  }
}
