class University {
  final List<String> domains;
  final String alphaTwoCode;
  final String country;
  final List<String> webPages;
  final String name;
  final String? stateProvince;
  University(
      {required this.domains,
      required this.alphaTwoCode,
      required this.country,
      required this.webPages,
      required this.name,
      required this.stateProvince});
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      domains: List.from(json['domains']),
      country: json['country'],
      name: json['name'],
      alphaTwoCode: json['alpha_two_code'],
      webPages: List.from(json['web_pages']),
      stateProvince: json['web_pages'],
    );
  }
}
