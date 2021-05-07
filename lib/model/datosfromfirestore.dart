class GetUser{
  final String userId;
  final String nombre;
  final double socio;

  GetUser({this.userId,this.nombre, this.socio});

  Map<String,dynamic> toMap(){
    return {
      'userId' : userId,
      'nombre' : nombre,
      'socio' : socio,
    };
  }

  GetUser.fromFirestore(Map<String, dynamic> firestore)
      : userId = firestore['userId'],
        nombre = firestore['nombre'],
        socio = firestore['socio'];
}