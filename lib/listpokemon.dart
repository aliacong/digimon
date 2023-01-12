import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListQuote extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const ListQuote({super.key});

  Future<List<dynamic>> _fecthListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digimon List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        snapshot.data[index]['img'],
                      ),
                      title: Text(
                        snapshot.data[index]['name'],
                        textAlign: TextAlign.justify,
                      ),
                      subtitle: Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        snapshot.data[index]['level'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
