class Usuario {
  final String dir;
  final String tel;
  final String soci;
  final String dnii;
  final String userId;
  final String tokenId;
  final String photo;
  final String eemail;
  final String nombre;
  final String nmedidor;
  final String klwats;

  Usuario({
    this.nombre,
    this.eemail,
    this.photo,
    this.userId,
    this.dir,
    this.tel,
    this.soci,
    this.dnii,
    this.tokenId,
    this.nmedidor,
    this.klwats,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'foto': photo,
      'email': eemail,
      'userId': userId,
      'direccion': dir,
      'telefono': tel,
      'socio': soci,
      'DNI': dnii,
      'tokens': tokenId,
      'medidorN': nmedidor,
      'Kilowats': klwats,
    };
  }

  

  Usuario.fromFirestore(Map<String, dynamic> firestore)
      : nmedidor = firestore['medidorN'],
        klwats = firestore['Kilowats'],
        nombre = firestore['nombre'],
        photo = firestore['foto'],
        eemail = firestore['email'],
        userId = firestore['userId'],
        dir = firestore['direccion'],
        tel = firestore['telefono'],
        soci = firestore['socio'],
        dnii = firestore['DNI'],
        tokenId = firestore['tokens'];
}
