import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

//Sofía Jiménez Durán
//2022-0905

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 6 (Couteau)',
      home: Menu(),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  int _paginaSeleccionada = 0; //índice de la página seleccionada en el menú

  //Lista de widgets que representan las diferentes opciones del menú:
  List<Widget> _opcionesMenu = <Widget>[
    Inicio(),
    Genero(),
    Edad(),
    Universidades(),
    Clima(),
    WordPress(),
    Contacto()
  ];

  //Actualiza el estado _paginaSeleccionada con el índice de la opción seleccionada:
  void _opcionPulsada(int index) {
    setState(() {
      _paginaSeleccionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Título dinámico en la AppBar basado en la opción de menú seleccionada:
    final tituloActual = _opcionesMenu[_paginaSeleccionada].runtimeType.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(tituloActual),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center()
            ),
            //lista de ListTile que representan las diferentes opciones del menú:
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                _opcionPulsada(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.wc),
              title: Text('Predecir género'),
              onTap: () {
                _opcionPulsada(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.onetwothree),
              title: Text('Predecir edad'),
              onTap: () {
                _opcionPulsada(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Universidades'),
              onTap: () {
                _opcionPulsada(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.sunny),
              title: Text('Clima'),
              onTap: () {
                _opcionPulsada(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('WordPress'),
              onTap: () {
                _opcionPulsada(5);
                Navigator.pop(context);
              },
            ),
             ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contacto'),
              onTap: () {
                _opcionPulsada(6);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        //Muestra el widget correspondiente a la opción de menú seleccionada.
        child: _opcionesMenu.elementAt(_paginaSeleccionada),
      ),
    );
  }
}

//Clase que muestra el inicio de la aplicacion:
class Inicio extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tarea 6 (Couteau)', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Image(image: AssetImage('assets/cajaHerramientas.jpg'), width: 600,)
        ],
      ),
    );
  }
}

//Clase que muestra la vista con la logica para predecir el genero: 
class Genero extends StatefulWidget {
  @override
  _GeneroState createState() => _GeneroState();
}

class _GeneroState extends State<Genero>{

  TextEditingController nombreController = TextEditingController();
  String genero = '';

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Predecir género', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 20),
          Text('Ingresar nombre para predecir el género del mismo:'),
          SizedBox(
            width: 300,
            child: TextField(controller: nombreController),
          ),
          SizedBox(height: 20,),
          ElevatedButton(child: Text('Predecir'), onPressed: () async {
            String name = nombreController.text;
              if (name.isNotEmpty) {
                String apiUrl = 'https://api.genderize.io/?name=$name';
                var response = await http.get(Uri.parse(apiUrl));
                var jsonData = jsonDecode(response.body);
                setState(() {
                  genero = jsonData['gender'];
                });
              }
          }),
          SizedBox(height: 40,),
          genero.isNotEmpty
              ? genero.toLowerCase() == 'female'
                  ? Icon(Icons.woman, size: 200, color: Colors.pink,) // Icono para género femenino
                  : Icon(Icons.man, size: 200, color: Colors.blue,) // Icono para género masculino
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

//Clase que muestra la vista con la logica para predecir la edad: 
class Edad extends StatefulWidget {
  @override
  _EdadState createState() => _EdadState();
}

class _EdadState extends State<Edad>{

  TextEditingController _nombreController = TextEditingController();
  int _edad = 0;
  String _mensaje = '';
  String _imagen = '';

  //Obtener la clasificacion mediante la edad:
  String _getMensaje(int edad) {
    if (edad < 18) {
      return 'Eres joven';
    } else if (edad >= 18 && edad < 65) {
      return 'Eres adulto';
    } else {
      return 'Eres anciano';
    }
  }

  //Obtener la imagen correspondiente dependiendo la edad:
  String _getImagen(int edad) {
    if (edad < 18) {
      return 'assets/joven.PNG';
    } else if (edad >= 18 && edad < 65) {
      return 'assets/adulto.PNG';
    } else {
      return 'assets/anciano.PNG';
    }
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Predecir edad', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Introducir nombre para predecir la edad del mismo:'),
          SizedBox(
            width: 300,
            child: TextField(controller: _nombreController,),
            ),
            SizedBox(height: 20,),
          ElevatedButton( child: Text('Predecir'), onPressed: () async {
              String nombre = _nombreController.text;
              if (nombre.isNotEmpty) {
                String apiUrl = 'https://api.agify.io/?name=$nombre';
                var response = await http.get(Uri.parse(apiUrl));
                var jsonData = jsonDecode(response.body);
                setState(() {
                  _edad = jsonData['age'];
                  _mensaje = _getMensaje(_edad);
                  _imagen = _getImagen(_edad);
                });
              }
            }),
          SizedBox(height: 20),
           _edad != 0
              ? Column(
                  children: [
                    Text('Tu edad es: $_edad', style: TextStyle(fontSize: 20),),
                    Text(_mensaje, style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Image.asset(
                      _imagen,
                      width: 200,
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

//Clase que muestra la vista con la logica para mostrar las universidades:
class Universidades extends StatefulWidget {
  @override
  _UniversidadesState createState() => _UniversidadesState();
}

class _UniversidadesState extends State<Universidades>{

  TextEditingController _paisController = TextEditingController();
  List<dynamic> _universidades = [];

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Universidades', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Ingresar pais en ingles para mostrar las universidades del mismo:'), 
          SizedBox(
            width: 400,
            child: TextField(controller: _paisController,),
          ),
          SizedBox(height: 20,),
          ElevatedButton(child: Text('Mostrar universidades'), onPressed: () async {
            String pais = _paisController.text;
            if (pais.isNotEmpty) {
              String apiUrl = 'http://universities.hipolabs.com/search?country=$pais';
              var response = await http.get(Uri.parse(apiUrl));
              var jsonData = jsonDecode(response.body);
              setState(() {
                _universidades = jsonData;
              });
            }
          } ), 
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _universidades.length,
              itemBuilder: (BuildContext context, int index) {
                var universidad = _universidades[index];
                return ListTile(
                  title: Text(universidad['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dominio: ${universidad['domains'].join(', ')}'),
                      Text('Página web: ${universidad['web_pages'].join(', ')}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Clase que muestra la vista con la logica para mostrar el clima actual en la Republica Dominicana: 
class Clima extends StatefulWidget {
  @override
  _ClimaState createState() => _ClimaState();
}

class _ClimaState extends State<Clima>{

 String _latitud = '18.7357'; // Latitud de República Dominicana
  String _longitud = '-70.1627'; // Longitud de República Dominicana
  String _climaDescripcion = '';
  double _temperatura = 0;
  String _iconoClima = '';

Future<void> obtenerClima() async {
    final String apiKey = '9edd26ed4d759e2a7033c5befab4fec3';
    final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$_latitud&lon=$_longitud&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _climaDescripcion = jsonData['weather'][0]['description'];
        _temperatura = jsonData['main']['temp'];
        _iconoClima = jsonData['weather'][0]['icon'];
      });
    } else {
      throw Exception('Error al obtener datos del clima');
    }
  }


  @override
  void initState() {
    super.initState();
    obtenerClima();
  }

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Clima en República Dominicana', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _iconoClima.isNotEmpty
              ? Image.network('http://openweathermap.org/img/w/$_iconoClima.png')
              : SizedBox.shrink(),
          SizedBox(height: 10),
          Text('$_temperatura °C', style: TextStyle(fontSize: 30)),
          Text(_climaDescripcion, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class WordPress extends StatefulWidget {
  @override
  _WordPressState createState() => _WordPressState();
}

class _WordPressState extends State<WordPress> {

  List<Map<String, dynamic>> _articulos = [];

  Future<void> obtenerArticulos() async {
    final String apiUrl = 'https://markmanson.net/wp-json/wp/v2/posts?per_page=3';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _articulos = List<Map<String, dynamic>>.from(jsonData.map((article) => {
          'titulo': article['title']['rendered'],
          'resumen': article['excerpt']['rendered'],
          'enlace': article['link'] 
        }));
      });
    } else {
      throw Exception('Error al obtener los artículos');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerArticulos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/Logo.png'), width: 100,),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.5, 
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _articulos.map((articulo) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articulo['titulo'],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _stripHtmlTags(articulo['resumen']),
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              if (await canLaunch(articulo['enlace'])) {
                                await launch(articulo['enlace']);
                              } else {
                                throw 'No se puede abrir el enlace ${articulo['enlace']}';
                              }
                            },
                            child: Text('Leer artículo'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Funcion para eliminar caracteres de codigo en los articulos:
  String _stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }
}

//Clase que muestra los datos de contacto:
class Contacto extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sofía Jiménez Durán', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Image(image: AssetImage('assets/Foto.png'), width: 300,),
          Text('sofia.jimenezdur@gmail.com', style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}
