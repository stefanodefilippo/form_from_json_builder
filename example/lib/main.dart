import 'package:flutter/material.dart';
import 'package:form_from_json_builder/form_from_json_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FormFromJson(
          jsonMap: const {
            "submitButtonTitle": "Submit",
            "sections": [
              {
                "title": "Dati generali",
                "elements": [
                  {
                    "type": "textField",
                    "name": "age",
                    "labelText": "Età",
                    "persistValue": true,
                    "keyboardType": "number"
                  },
                  {
                    "type": "textField",
                    "name": "ISEE",
                    "labelText": "ISEE",
                    "persistValue": true,
                    "keyboardType": "number"
                  },
                  {
                    "type": "checkBox",
                    "name": "hasRedditoCittadinanza",
                    "labelText": "Percepisci il Reddito di Cittadinanza?",
                    "persistValue": true,
                  },
                ]
              },
              {
                "title": "Stato occupazionale",
                "elements": [
                  {
                    "type": "dropDown",
                    "name": "workingState",
                    "labelText": "Your occupation",
                    "items": [
                      {
                        "text": "Occupato",
                        "value": "working",
                      },
                      {"text": "Studente", "value": "student"},
                      {"text": "Disoccupato", "value": "notWorking"},
                      {
                        "text": "Attività lavorativa ridotta o sospesa",
                        "value": "suspended"
                      }
                    ],
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "visible": "workingState == notWorking",
                    "name": "stagional",
                    "labelText":
                        "Eri un lavoratore stagionale o occasionale o autonomo che ha perso il lavoro a causa dell'emergenza sanitaria?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "visible": "occup == notWorking",
                    "name": "voluntaryDismissal",
                    "labelText":
                        "Sei disoccupato a seguito di dimissioni volontarie (eccetto che nel caso di dimissioni per giusta causa)?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "visible": "occup == notWorking",
                    "name": "contributionNaspi",
                    "labelText":
                        "Hai realizzato, nei 4 anni precedenti l’inizio del periodo di disoccupazione, almeno 13 settimane di contribuzione contro la disoccupazione?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "visible": "occup == suspended",
                    "name": "fundCompany",
                    "labelText":
                        "Alla tua azienda sono stati applicati i Fondi di solidarietà o il Fondo di integrazione salariale?",
                    "persistValue": true,
                  },
                ]
              },
              {
                "title": "Dati nucleo famigliare",
                "elements": [
                  {
                    "type": "textField",
                    "name": "children",
                    "labelText": "Numero di figli minori a carico",
                    "persistValue": true,
                    "keyboardType": "number"
                  },
                  {
                    "type": "checkBox",
                    "visible": "children > 0",
                    "name": "hasChildrenNursery",
                    "labelText":
                        "Hai almeno un figlio iscritto ad un asilo nido?",
                    "persistValue": true,
                  },
                  {
                    "type": "textField",
                    "name": "childrenRange1821",
                    "labelText":
                        "Numero di figli tra i 18 e i 21 anni a carico",
                    "persistValue": true,
                    "keyboardType": "number"
                  },
                  {
                    "type": "checkBox",
                    "name": "newBorn",
                    "labelText":
                        "Sei in attesa di un figlio oppure ne hai avuto uno da meno di 90 giorni?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "name": "hasDisableSon",
                    "labelText": "Hai a carico uno o più figli con disabilità?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "name": "isDivorced",
                    "labelText": "Sei separato/a o divorziato/a?",
                    "persistValue": true,
                  },
                ]
              },
              {
                "title": "Altri dati",
                "elements": [
                  {
                    "type": "checkBox",
                    "name": "isLandlord",
                    "labelText": "Sei locatore di un appartamento in affitto?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "name": "isRaiPayed",
                    "labelText":
                        "Sei in regola con il pagamento del canone RAI?",
                    "persistValue": true,
                  },
                  {
                    "type": "checkBox",
                    "name": "hasCaretaker",
                    "labelText":
                        "Hai a carico una persona anziana che ha assunto colf o badanti?",
                    "persistValue": true,
                  },
                ]
              },
            ],
          },
          formKey: formKey,
          textFieldDecoration: InputDecoration(
            labelStyle: TextStyle(color: Theme.of(context).primaryColorDark),
            focusedBorder: const OutlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(),
          ),
          dropDownHintStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          checkBoxLabelStyle: TextStyle(
            fontSize: 17,
            color: Theme.of(context).primaryColorDark,
          ),
          sectionTitleStyle: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          sectionTitleContainerDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          spaceBetweenQuestions: 10,
          submitButtonTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          submitButtonColor: Colors.green,
          submitButtonShapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
          onSubmit: (values) {
            //print(values);
          },
        ),
      ),
    );
  }
}
