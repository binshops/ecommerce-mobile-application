class PrestashopCategory {
  String label;
  String url;
  List<PrestashopCategory> children = [];
  List<String> imageUrls = [];
  String pageIdentifier;

  PrestashopCategory(
      {this.children,
      this.imageUrls,
      this.label,
      this.pageIdentifier,
      this.url});

  String categoryID() {
    var underLineIndex = this.pageIdentifier.indexOf("-");
    var id = this
        .pageIdentifier
        .substring(underLineIndex + 1, this.pageIdentifier.length);
    return id;
  }

  PrestashopCategory.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      imageUrls.add(json['image']['src']);
    } else if (json['image_urls'] != null)
      for (var url in json['image_urls']) {
        imageUrls.add(url);
      }
    if (json['children'] != null) {
      for (var child in json['children']) {
        children.add(PrestashopCategory.fromJson(child));
      }
    }
    label = json['label'];
    pageIdentifier = json['page_identifier'];
    url = json['url'];
  }
}
