import 'package:filmler_app_sqlite/DetaySayfa.dart';
import 'package:filmler_app_sqlite/Filmler.dart';
import 'package:filmler_app_sqlite/Filmlerdao.dart';
import 'package:filmler_app_sqlite/Kategoriler.dart';
import 'package:filmler_app_sqlite/Yonetmenler.dart';
import 'package:flutter/material.dart';

class FilmlerSayfa extends StatefulWidget {
 Kategoriler kategori;

 FilmlerSayfa({required this.kategori});


  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {
  Future<List<Filmler>> filmleriGoster(int kategori_id) async{

    var filmlerListesi =await Filmlerdao().tumFilmlerByKategoriId(kategori_id);
    return filmlerListesi;

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler :${widget.kategori.kategori_ad}"),
      ),
      body: FutureBuilder<List<Filmler>>(
        future:filmleriGoster(widget.kategori.kategori_id),
        builder:(context,snapshot){
          if(snapshot.hasData){
            var filmlerListesi = snapshot.data;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Bir satırda 2 film
                childAspectRatio: 2 / 3.5,  //oran
              ),
              itemCount: filmlerListesi!.length,
              itemBuilder:(context,indeks){
                var film = filmlerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => DetaySayfa(film: film,)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("resimler/${film.film_resim}"),
                        ),
                        Text(film.film_ad,style: TextStyle(fontSize:16,fontWeight: FontWeight.bold ),),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      ),
    );
  }
}
