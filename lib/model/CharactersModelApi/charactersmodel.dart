// To parse this JSON data, do
//
//     final charactersModel = charactersModelFromJson(jsonString);

import 'dart:convert';

CharactersModel charactersModelFromJson(String str) => CharactersModel.fromJson(json.decode(str));

String charactersModelToJson(CharactersModel data) => json.encode(data.toJson());

class CharactersModel {
    Data? data;

    CharactersModel({
        this.data,
    });

    factory CharactersModel.fromJson(Map<String, dynamic> json) => CharactersModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    Characters? characters;

    Data({
        this.characters,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        characters: json["characters"] == null ? null : Characters.fromJson(json["characters"]),
    );

    Map<String, dynamic> toJson() => {
        "characters": characters?.toJson(),
    };
}

class Characters {
    Info? info;
    List<Result>? results;

    Characters({
        this.info,
        this.results,
    });

    factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Info {
    int? count;

    Info({
        this.count,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}

class Result {
    String? id;
    String? name;
    String? image;
    Status? status;
    Species? species;
    String? type;
    Location? origin;
    Gender? gender;
    Location? location;
    List<Location>? episode;

    Result({
        this.id,
        this.name,
        this.image,
        this.status,
        this.species,
        this.type,
        this.origin,
        this.gender,
        this.location,
        this.episode,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]]!,
        type: json["type"],
        origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
        gender: genderValues.map[json["gender"]]!,
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        episode: json["episode"] == null ? [] : List<Location>.from(json["episode"]!.map((x) => Location.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "origin": origin?.toJson(),
        "gender": genderValues.reverse[gender],
        "location": location?.toJson(),
        "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x.toJson())),
    };
}

class Location {
    String? id;

    Location({
        this.id,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}

enum Gender {
    FEMALE,
    MALE,
    UNKNOWN
}

final genderValues = EnumValues({
    "Female": Gender.FEMALE,
    "Male": Gender.MALE,
    "unknown": Gender.UNKNOWN
});

enum Species {
    ALIEN,
    HUMAN
}

final speciesValues = EnumValues({
    "Alien": Species.ALIEN,
    "Human": Species.HUMAN
});

enum Status {
    ALIVE,
    DEAD,
    UNKNOWN
}

final statusValues = EnumValues({
    "Alive": Status.ALIVE,
    "Dead": Status.DEAD,
    "unknown": Status.UNKNOWN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
