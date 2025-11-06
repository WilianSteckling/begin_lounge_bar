class UserModel {
  final String name;
  final String username;
  final String company;
  final String sector;
  final String about;
  final String whatsapp;
  final String image; // URL ou Base64 (para a imagem de perfil)
  final String memberSince;

  const UserModel({
    required this.name,
    required this.username,
    required this.company,
    required this.sector,
    required this.about,
    required this.whatsapp,
    required this.image,
    this.memberSince = 'Janeiro 2024',
  });

  UserModel copyWith({
    String? name,
    String? username,
    String? company,
    String? sector,
    String? about,
    String? whatsapp,
    String? image,
    String? memberSince,
  }) {
    return UserModel(
      name: name ?? this.name,
      username: username ?? this.username,
      company: company ?? this.company,
      sector: sector ?? this.sector,
      about: about ?? this.about,
      whatsapp: whatsapp ?? this.whatsapp,
      image: image ?? this.image,
      memberSince: memberSince ?? this.memberSince,
    );
  }
}