import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'album.dart';

class AlbumsService {
  String get apiUrl => '${dotenv.env['API_URL']}/albumes';

  Future<Album> fetchAlbumes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return albumFromJson(response.body);
      } else {
        throw Exception('Error al cargar los álbumes: ${response.statusCode}');
      }
    } catch (e) {
      print("Error al obtener los álbumes: $e");
      throw Exception('Error en la conexión con la API');
    }
  }

  Future<AlbumData> fetchAlbumById(String id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        final album = albumFromJson(response.body);
        if (album.data.isNotEmpty) {
          return album.data.first;
        }
        throw Exception('Álbum no encontrado');
      } else {
        throw Exception('Error al cargar el álbum: ${response.statusCode}');
      }
    } catch (e) {
      print("Error al obtener el álbum: $e");
      throw Exception('Error en la conexión con la API');
    }
  }

  Future<Album> fetchAlbumesByArtista(String artista) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/buscar/artista?artista=$artista'),
      );

      if (response.statusCode == 200) {
        return albumFromJson(response.body);
      } else {
        throw Exception('Error al buscar álbumes por artista');
      }
    } catch (e) {
      print("Error al buscar por artista: $e");
      throw Exception('Error en la conexión con la API');
    }
  }

  Future<Album> fetchAlbumesByGenero(String genero) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/buscar/genero?genero=$genero'),
      );

      if (response.statusCode == 200) {
        return albumFromJson(response.body);
      } else {
        throw Exception('Error al buscar álbumes por género');
      }
    } catch (e) {
      print("Error al buscar por género: $e");
      throw Exception('Error en la conexión con la API');
    }
  }
}