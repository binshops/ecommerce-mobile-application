class Slide {
  String idSlide;
  String position;
  String active;
  String title;
  String url;
  String legend;
  String description;
  String image;
  String imageUrl;

  Slide(
      {this.idSlide,
      this.position,
      this.active,
      this.title,
      this.url,
      this.legend,
      this.description,
      this.image,
      this.imageUrl});

  Slide.fromJson(Map<String, dynamic> json) {
    idSlide = json['id_slide'];
    position = json['position'];
    active = json['active'];
    title = json['title'];
    url = json['url'];
    legend = json['legend'];
    description = json['description'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_slide'] = this.idSlide;
    data['position'] = this.position;
    data['active'] = this.active;
    data['title'] = this.title;
    data['url'] = this.url;
    data['legend'] = this.legend;
    data['description'] = this.description;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
