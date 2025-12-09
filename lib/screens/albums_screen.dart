import 'package:flutter/material.dart';
import 'albumsService.dart';
import 'album.dart';

class AlbumsScreen extends StatelessWidget {
  final AlbumsService albumsService = AlbumsService();

  AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final iconColor = Theme.of(context).iconTheme.color;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Albums',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: FutureBuilder<Album>(
        future: albumsService.fetchAlbumes(),
        builder: (context, snapshot) {
          // Estado de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando álbumes...'),
                ],
              ),
            );
          }

          // Estado de error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar los álbumes',
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Forzar rebuild para reintentar
                      (context as Element).markNeedsBuild();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          // Sin datos
          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.album_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay álbumes disponibles',
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            );
          }

          // Datos cargados correctamente
          final albums = snapshot.data!.data;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: albums.length,
            itemBuilder: (BuildContext context, int index) {
              final album = albums[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'albums_screen_item',
                    arguments: <String, dynamic>{
                      'id': album.id,
                      'title': album.nombre,
                      'artist': album.artista,
                      'cover': album.imagen,
                      'releaseDate': album.anioLanzamiento.toString(),
                      'tracks': album.canciones,
                      'genre': album.genero,
                    },
                  );
                },
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Imagen del álbum
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: album.imagen.startsWith('http')
                            ? Image.network(
                          album.imagen,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.album,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                            : Image.asset(
                          album.imagen,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.album,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Información del álbum
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              album.nombre,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              album.artista,
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor?.withOpacity(0.7),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              album.genero,
                              style: TextStyle(
                                fontSize: 12,
                                color: iconColor?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Año y cantidad de canciones
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            album.anioLanzamiento.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.music_note,
                                size: 16,
                                color: iconColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${album.canciones.length}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor?.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}