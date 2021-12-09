class PrestaBanner {
  String _imageUrl;
  String _bannerLink;
  String _bannerDesc;

  String get bannerDesc => _bannerDesc;

  String get bannerLink => _bannerLink;

  String get imageUrl => _imageUrl;

  PrestaBanner({String imageUrl, String bannerLink, String bannerDesc})
      : _bannerDesc = bannerDesc ?? '',
        _bannerLink = bannerLink ?? '',
        _imageUrl = imageUrl ?? '';

  PrestaBanner.fromJson(Map<String, dynamic> json) {
    _imageUrl = json['image_url'] ?? '';
    _bannerLink = json['banner_link'] ?? '';
    _bannerDesc = json['banner_desc'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['banner_link'] = this.bannerLink;
    data['banner_desc'] = this.bannerDesc;
    return data;
  }
}
