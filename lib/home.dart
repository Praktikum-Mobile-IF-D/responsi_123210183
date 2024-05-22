import 'package:flutter/material.dart';
import 'api_service.dart';
import 'detail.dart';

// Buat kelas HomePage
class HomePage extends StatelessWidget {
  var SharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 226, 215, 215),
      ),
      body: ApiListPage(), // Tampilkan ApiListPage
    );
  }


class ApiListPage extends StatefulWidget {
  @override
  _ApiListPageState createState() => _ApiListPageState();
}

class _ApiListPageState extends State<ApiListPage> {
  late Future<List<Api>> futureApis;

  @override
  void initState() {
    futureApis =
        ApiService.fetchApis(); // Panggil metode fetchApis dari ApiService
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Api>>(
      future: futureApis,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan indikator loading jika sedang memuat data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Tampilkan pesan error jika terjadi kesalahan
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Tampilkan data jika berhasil diambil
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Api api = snapshot.data![index];
              return ListTile(
                title: Text(api.name),
                subtitle: Text(api.description),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailPage(api: api),
                  //   ),
                  // );
                },
              );
            },
          );
        }
      },
    );
    }
  }
}