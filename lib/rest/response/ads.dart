class Ad{

  Ad({
    this.company,
    this.url,
    this.text,
  });

  String company;
  String url;
  String text;

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      company: json["company"],
      url: json["url"],
      text: json["text"],
    );
  }

  Map<String, dynamic> toJson() => {
    "company": company,
    "url": url,
    "text": text,
  };

  @override
  String toString() {
    return 'Ad{company: $company, url: $url, text: $text}';
  }


}