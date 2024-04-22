// To parse this JSON data, do
//
//     final recipeResponseModel = recipeResponseModelFromJson(jsonString);

import 'dart:convert';

RecipeResponseModel recipeResponseModelFromJson(String str) =>
    RecipeResponseModel.fromJson(json.decode(str));

String recipeResponseModelToJson(RecipeResponseModel data) =>
    json.encode(data.toJson());

class RecipeResponseModel {
  List<Result>? results;
  int? offset;
  int? number;
  int? totalResults;

  RecipeResponseModel({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  factory RecipeResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipeResponseModel(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
      };
}

class Result {
  int? id;
  String? title;
  String? image;
  String? imageType;
  Nutrition? nutrition;

  Result({
    this.id,
    this.title,
    this.image,
    this.imageType,
    this.nutrition,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: json["imageType"],
        nutrition: json["nutrition"] == null
            ? null
            : Nutrition.fromJson(json["nutrition"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageType,
        "nutrition": nutrition?.toJson(),
      };
}

class Nutrition {
  List<Nutrient>? nutrients;

  Nutrition({
    this.nutrients,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
        nutrients: json["nutrients"] == null
            ? []
            : List<Nutrient>.from(
                json["nutrients"]!.map((x) => Nutrient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nutrients": nutrients == null
            ? []
            : List<dynamic>.from(nutrients!.map((x) => x.toJson())),
      };
}

class Nutrient {
  String? name;
  double? amount;
  String? unit;

  Nutrient({
    this.name,
    this.amount,
    this.unit,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        name: json["name"],
        amount: json["amount"]?.toDouble(),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "unit": unit,
      };
}
