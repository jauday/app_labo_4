import 'dart:convert';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));

String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  String msg;
  List<AlbumData> data;

  Album({
    required this.msg,
    required this.data,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    msg: json["msg"] ?? '',
    data: json["data"] == null
        ? []
        : List<AlbumData>.from(json["data"].map((x) => AlbumData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AlbumData {
  String id;
  String nombre;
  String artista;
  String genero;
  String imagen;
  int anioLanzamiento;
  List<String> canciones;

  AlbumData({
    required this.id,
    required this.nombre,
    required this.artista,
    required this.genero,
    required this.imagen,
    required this.anioLanzamiento,
    required this.canciones,
  });

  factory AlbumData.fromJson(Map<String, dynamic> json) => AlbumData(
    id: json["id"]?.toString() ?? '',
    nombre: json["nombre"] ?? 'Sin nombre',
    artista: json["artista"] ?? 'Artista desconocido',
    genero: json["genero"] ?? 'Sin género',
    imagen: json["imagen"] ?? 'assets/albums/album.png',
    anioLanzamiento: _parseAnio(json["anioLanzamiento"]),
    canciones: json["canciones"] == null
        ? []
        : List<String>.from(json["canciones"].map((x) => x.toString())),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "artista": artista,
    "genero": genero,
    "imagen": imagen,
    "anioLanzamiento": anioLanzamiento,
    "canciones": List<dynamic>.from(canciones.map((x) => x)),
  };

  static int _parseAnio(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}