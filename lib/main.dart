// importação da classe material
import 'package:flutter/material.dart';

// função para a incialização do app
void main() {
  runApp(const MyApp());
}

// classe do MyApp com State mutável
class MyApp extends StatefulWidget {
  // construtor da classe
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// função privada de validação sendo possível ser uma String vazia, com os parâmetros de valores do campo de texto e o valor do texto do textfield
String? _validateField(String value, String fieldName) {
  // se o valor for vazio
  if (value.isEmpty) {
    // retorna mensagem para preenchimento dos campos
    return 'Por favor, coloque $fieldName';
  }
  // caso não seja vazio retorna nada
  return null;
}

class _MyAppState extends State<MyApp> {
  // controladores de texto de altura e peso
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // variável global que é uma chave importante para a validação de formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // variável de texto ao final da página
  String _infoText = 'Infrome seus dados!';

  // função de reset do botão superior direito da página para limpar valores
  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    _infoText = 'Informe seus dados!';
  }

  // função com a lógica de calculo de imc com atribuição de resultados
  void calculate() {
    // setState para mudança de estados da interface
    setState(() {
      // variaveis float de altura e peso que pegam os controladores de texto e tranformas em float para calculos da lógica
      double weight = double.parse(weightController.text);
      // esse em específico dividindo por 100 por ser uma medida em centímetros
      double height = double.parse(heightController.text) / 100;
      // variável float do imc peso divido pela altura multiplicada por ela mesma
      double imc = weight / (height * height);
      print(imc);
      // toda a lógica de resultados do cálculo do imc
      if (imc < 18.6) {
        // em todos digo que a variável privada _infoText vai mostrar uma mensagem personalizada referente ao resultado pegando o número float resultado do calculo transformando-o em uma String e manipulando ela deixa somente com 4 digitos
        _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente Acima do Peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculadora de IMC',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                // botão chamando a função de reset de campo textos
                onPressed: () => setState(() {
                  _resetFields();
                }),
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          // Form para ser possível colocar validações de formulários
          child: Form(
            // chave global para validação
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  // controlador pegando a variável de controle de texto que serve para armazenamento e alteração do mesmo
                  controller: weightController,
                  // o tipo de input que será sempre números
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  // a validação caso os campos estejam vázios mostra mensagem de erro
                  validator: (value) => _validateField(value!, 'seu peso'),
                ),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  validator: (value) => _validateField(value!, 'sua altura'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // ao ser pressionado o botão calcular pega a chave global de validação do form, verifica o estado atual dela com a validação
                        if (_formKey.currentState!.validate()) {
                          // se estiver ok, chama a função de calculo do imc
                          calculate();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  // o texto onde irá aparecer o resultado do imc
                  _infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
