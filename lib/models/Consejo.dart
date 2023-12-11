class Consejo {
  String titulo, contenido;

  Consejo({required this.titulo, required this.contenido});

  factory Consejo.fromJson(Map<String, dynamic> data) {
    return Consejo(titulo: data['titulo'], contenido: data['contenido']);
  }
}
