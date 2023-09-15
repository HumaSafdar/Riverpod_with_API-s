import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_apiiiiiiiiiiiiiiiiiiiiiiiii/album.dart';
import 'package:riverpod_apiiiiiiiiiiiiiiiiiiiiiiiii/album_state.dart';
import 'package:riverpod_apiiiiiiiiiiiiiiiiiiiiiiiii/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
   ref.read(AlbumStateProvider.notifier).fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer(builder: (context, ref, child) {
        var state=ref.watch(AlbumStateProvider);
        if(state is AlbumInitialState){
          return const AlbumInitialWidget();
        }
        else if(state is AlbumLoadingState){
          return  const AlbumLoadingWidget();
        }
        else if(state is AlbumLoadedState){
          return AlbumLoadedWidget(albums: state.albums);
        }else{
          return AlbumErrorWidget(errorMessage: (state as AlbumErrorState).errorMessage);
        }
      
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AlbumInitialWidget extends StatelessWidget {
  const AlbumInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text('Click Here to Fetch Data')),
    );
  }
}

class AlbumLoadingWidget extends StatelessWidget {
  const AlbumLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class AlbumErrorWidget extends StatelessWidget {
  const AlbumErrorWidget({required this.errorMessage, super.key});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.red,
        child: const Text('Error Message'),
      ),
    );
  }
}

class AlbumLoadedWidget extends StatelessWidget {
  const AlbumLoadedWidget({required this.albums, super.key});
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text(albums[index].id.toString()),
              ),
              title: Text(albums[index].title!),
              trailing: Text(albums[index].userId.toString()),
            ));
  }
}
