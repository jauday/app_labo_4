import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'playlist.dart';

class PlaylistService {
  String get apiUrl => '${dotenv.env['API_URL']}/playlists';

  Future<Playlist> fetchPlaylists() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return playlistFromJson(response.body);
      } else {
        throw Exception('Error al cargar las playlists');
      }
    } catch (e) {
      print("Error al obtener los datos: $e");
      throw Exception('Error en la conexión con la API');
    }
  }
}
