import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChessBoardScreen(),
                  ),
                );
              },
              child: Text('Играть в шахматы'),
            ),
            const SizedBox(height: 20),
            Text(
              "Boris Bidjan Saberi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Нажми кнопку выше чтобы увидеть шахматную доску",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

// Новый экран с шахматной доской
class ChessBoardScreen extends StatefulWidget {
  const ChessBoardScreen({super.key});

  @override
  _ChessBoardScreenState createState() => _ChessBoardScreenState();
}

class _ChessBoardScreenState extends State<ChessBoardScreen> {
  bool _isExploded = false;
  List<List<bool>> _boardState = [];

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  void _resetBoard() {
    // Создаем доску 8x8 с чередующимися цветами
    List<List<bool>> newBoard = [];
    for (int i = 0; i < 8; i++) {
      List<bool> row = [];
      for (int j = 0; j < 8; j++) {
        // true - белая клетка, false - черная
        row.add((i + j) % 2 == 0);
      }
      newBoard.add(row);
    }
    setState(() {
      _boardState = newBoard;
      _isExploded = false;
    });
  }

  void _explodeBoard() {
    setState(() {
      _isExploded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Взрывающиеся шахматы'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              _isExploded ? '💥 БУМ! 💥' : 'Шахматная доска',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                  itemCount: 64,
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;
                    bool isWhite = _boardState[row][col];
                    if (_isExploded) {
                      // Взрыв - показываем случайные цвета
                      return Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: _getRandomColor(),
                          border: Border.all(color: Colors.black),
                        ),
                      );
                    } else {
                      // Нормальная доска
                      return Container(
                        margin: EdgeInsets.all(1),
                        color: isWhite ? Colors.white : Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _explodeBoard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'ВЗОРВАТЬ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                
                ElevatedButton(
                  onPressed: _resetBoard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'СБРОСИТЬ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Вернуться назад
            },
            child: Text('Назад к Борису'),
          ),
        ],
      ),
    );
  }
  
  Color _getRandomColor() {
    // Случайный цвет для эффекта взрыва
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ];
    return colors[(DateTime.now().millisecond % colors.length)];
  }
}
