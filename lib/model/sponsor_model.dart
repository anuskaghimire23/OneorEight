class SponsorModel {
    SponsorModel({
        required this.success,
        required this.docs,
    });

    final bool? success;
    final List<Doc> docs;

    factory SponsorModel.fromJson(Map<String, dynamic> json){ 
        return SponsorModel(
            success: json["success"],
            docs: json["docs"] == null ? [] : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
        );
    }

}

class Doc {
    Doc({
        required this.id,
        required this.name,
        required this.website,
        required this.logo,
    });

    final int? id;
    final String? name;
    final String? website;
    final Logo? logo;

    factory Doc.fromJson(Map<String, dynamic> json){ 
        return Doc(
            id: json["id"],
            name: json["name"],
            website: json["website"],
            logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        );
    }

}

class Logo {
    Logo({
        required this.url,
    });

    final String? url;

    factory Logo.fromJson(Map<String, dynamic> json){ 
        return Logo(
            url: json["url"],
        );
    }

}
