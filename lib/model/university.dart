class University {
  final List<String> domains;
  final String alphaTwoCode;
  final String country;
  final List<String> webPages;
  final String name;
  final String? stateProvince;
  bool isSave = false;
  University(
      {required this.domains,
      required this.alphaTwoCode,
      required this.country,
      required this.webPages,
      required this.name,
      required this.stateProvince});
  factory University.fromJson(Map json) {
    return University(
      domains: List.from(json['domains']),
      country: json['country'],
      name: json['name'],
      alphaTwoCode: json['alpha_two_code'],
      webPages: List.from(json['web_pages']),
      stateProvince: json['state-province'],
    );
  }
  Map toJson() => {
        'domains': domains,
        'country': country,
        'name': name,
        'alpha_two_code': alphaTwoCode,
        'web_pages': webPages,
        'state-province': stateProvince,
      };
}
