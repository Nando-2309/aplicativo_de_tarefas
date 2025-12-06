import 'package:flutter/material.dart';
import 'package:meu_primeiro_projeto/components/difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;


  Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);

  int nivel = 0;
  int mestreJedi = 0;
  bool levelMax = false;

  final List<Color> mestreJediColors = const[
    Color.fromARGB(255, 105, 105, 105),
    Colors.yellow,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.black,
    Color.fromARGB(255, 255, 127, 80),

  ];

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {


  bool assetOrNetWork(){
    if(widget.foto.contains('http')){
      return false;
    }
    return true;
  }
  void _mostrarDialogReinicio(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,//barrierDismissible controla se o usuário pode fechar o diálogo tocando fora dele (na "barreira" em volta).
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Você agora é um Mestre Jedi !'),
          content: const Text('Deseja reiniciar sua jornada?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // fecha o diálogo, não reinicia
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // fecha o diálogo
                setState(() {
                  widget.nivel = 0;
                  widget.mestreJedi = 0;
                  widget.levelMax = false;
                });
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    //print('Caminho da imagem: ${widget.foto}');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.mestreJediColors[widget.mestreJedi],
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child:assetOrNetWork()? Image.asset(
                          widget.foto,
                          fit: BoxFit.cover,
                        ):Image.network(
                          widget.foto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            //quando eu só quero alterar tamanho ao invés de formato, eu uso o SizeBox ao invés de Container
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        Difficulty(
                          dificultyLevel: widget.dificuldade,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                              if ((widget.nivel / widget.dificuldade) / 10 > 1) {
                                if (widget.mestreJedi < widget.mestreJediColors.length - 1) {
                                  widget.mestreJedi++;
                                  widget.nivel = 0;
                                } else {
                                  widget.levelMax = true;
                                  // Aqui chama o diálogo para perguntar se quer reiniciar
                                  _mostrarDialogReinicio(context);
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'Up',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    //aqui nesse EdgeInsets eu posso informar em qual lado eu quero o padding
                    child: SizedBox(
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.levelMax == true ? 'Maestria Completa' : 'Nível ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
