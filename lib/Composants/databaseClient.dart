import 'dart:io';

import 'package:premierchoixapp/Models/panier_classe_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {
  Database _database;

  // Get the database and check if it is empty or not
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await create();
      return _database;
    }
  }

  // Create database
  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databaseDirectory = join(directory.path, "database.db");
    var bdd =
        await openDatabase(databaseDirectory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  // Create the table session and user table
  Future _onCreate(Database db, int version) async {

    await db.execute('''
    CREATE TABLE panier(
    id INTEGER PRIMARY KEY, 
    nomDuProduit TEXT NOT NULL,
    prix INTEGER,
    description TEXT ,
    image1 TEXT ,
    taille TEXT,
    categorie TEXT,
    sousCategorie TEXT,
    idProduitCategorie TEXT,
    numberStar INTEGER,
    reference TEXT
    )
    ''');
  }


  // INSERT THE VALUE IN PANIER TABLE

  Future<PanierClasseSqflite> insertPanier(PanierClasseSqflite panier) async {
    Database db = await database;
    panier.id = await db.insert("panier", panier.toMap());
    return panier;
  }

  // READ DATA IN PANIER TABLE

  Future<List<PanierClasseSqflite>> readPanierData() async{
    Database db = await database;
    List<Map<String, dynamic>> resultat = await db.rawQuery("SELECT * FROM panier");
    List<PanierClasseSqflite> paniers = [];
    resultat.forEach((element) {
      PanierClasseSqflite panierClasseSqflite = PanierClasseSqflite();
      panierClasseSqflite.fromMap(element);
      paniers.add(panierClasseSqflite);
    });
    return paniers;
  }

  // DELETE DATA IN PANIER TABLE

  Future<int> deleteItemPanier(int id, String table) async {
    Database db = await database;
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

}
