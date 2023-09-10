import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 224, 41, 215),
      ),
      home: const MyHomePage(),
    );
  }
}
//------------------------------------------------------------------------------
class Pendiente {
  final String tarea;
  bool completada;

  Pendiente({
    required this.tarea,
    this.completada = false,
  });
}
//--------------------------------------------------------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Pendiente> todos = [
    Pendiente(tarea: "Tarea de Moviles"),
    Pendiente(tarea: "Examen de Sistemas programables"),
    Pendiente(tarea: "Cita medica"),
    Pendiente(tarea: "Examen de Conmmutacion"),
    Pendiente(tarea: "Sacar una constancia"),
  ];
  int _selectedRadio = -1; 


  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _showDatePicker() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      
      print("Fecha seleccionada: $selectedDate");
    }
  }

  Future<void> _showAlertDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informacion'),
          content: const Text('Nayeli Armendariz 19540439'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

   Future<void> _AlertDialogActivado() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modo oscuro'),
          content: const Text('Activado'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _AlertDialogDesactivado() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modo oscuro'),
          content: const Text('Desactivado'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SingleChildScrollView(
        child: Column(
          children: todos.map((todo) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(todo.tarea),
                leading: Checkbox(
                  value: todo.completada,
                  onChanged: (bool? value) {
                    setState(() {
                      todo.completada = value!;
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
       _buildSecondTab(),
   
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de pendientes'),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 214, 9, 9),
              ),
              child: Text('Drawer'),
            ),
            ListTile(
              title: const Text('Agregar tarea al calendario'),
              onTap: () {
                
                _showDatePicker(); // DatePicker
              },
            ),
            ListTile(
              title: const Text('Informacion'),
              onTap: () {
                
                _showAlertDialog(); // AlertDialog
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  //-----------------------------------------------
  Widget _buildSecondTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Modo oscuro:',
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: _selectedRadio,
                onChanged: (int? value) {
                  setState(() {
                    _selectedRadio = value!;
                  });
                },
              ),
              const Text('Activado'),
              Radio(
                value: 2,
                groupValue: _selectedRadio,
                onChanged: (int? value) {
                  setState(() {
                    _selectedRadio = value!;
                  });
                },
              ),
              const Text('Desactivado'),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              
              if (_selectedRadio == 1) {
                
                _AlertDialogActivado();
              } else if (_selectedRadio == 2) {
                _AlertDialogDesactivado();
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}