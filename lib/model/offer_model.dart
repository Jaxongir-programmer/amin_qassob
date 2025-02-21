
class OfferModel {
  String id;
  String title;
  String link;
  String image;
  OfferModel(this.id, this.title,this.link,this.image);

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    json["id"] ?? "",
    json["title"] ?? "",
    json["link"] ?? "",
    json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "link": link,
    "image": image,
  };
}