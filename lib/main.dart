import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              CircleAvatar(
                radius: 129,
                backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/2/28/Boris_Bidjan_Saberi%2C_Paris_Fashion_Week%2C_2012.jpg',
              ),
          ),
          SizedBox(height: 20.0), ElevatedButton(
  onPressed: () {
    // Код, который выполнится при нажатии на кнопку
    print('Кнопка нажата!');
  },
  child: Text('нажми чтобы увидеть бориса'),
),
              SizedBox(height: 20.0), Text ("Boris_Bidjan_Saberi"),
              Expanded(
                child: Center(
                  child: Text("Expanded Widget"),
                ),
              ),
            ],
          ),
        ),
      
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
            
        ),
      ),
    );
  }
}

