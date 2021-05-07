class Consumo {
  final String periodo;
  final String lecturaanterior;
  final String totalpesos;
  final String kilowats;
  final String lecturaactual;
  final String userid;
  final String nmedidor;
  final String estado;
  final String vence;

  Consumo({
    this.lecturaactual,
    this.lecturaanterior,
    this.totalpesos,
    this.periodo,
    this.kilowats,
    this.userid,
    this.estado,
    this.nmedidor,
    this.vence
  });

  Map<String, dynamic> toMap() {
    return {
      'periodo': periodo,
      'kilowats': kilowats,
      'lecturaactual': lecturaactual,
      'lecturaanterior': lecturaanterior,
      'totalpesos': totalpesos,
      'estado': estado,
      'nmedidor': nmedidor,
      'vence' : vence,
    };
  }
}
