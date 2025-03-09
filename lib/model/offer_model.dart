
class OfferModel {
  int id;
  String title;
  String link;
  String image;
  OfferModel(this.id, this.title,this.link,this.image);

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    json["id"] ?? 0,
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