import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtextapp/actordata.dart';
import 'package:testtextapp/ui/page.dart';
import 'package:testtextapp/ui/theme.dart';
import 'package:testtextapp/event_stream.dart';
import 'package:testtextapp/connection.dart';
import 'event.dart';
import 'package:testtextapp/storage.dart';



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EventStream? eventStream;
  AppConnection? connection;
  BotConnection? botConnection;
  @override
  void initState(){
    super.initState();
    connect();
  }

  void connect(){
    setState(() {
      connection = AppConnection();
      botConnection = BotConnection(connection: connection!, dataStore: DataStore());
      connection!.addOrbListener('connect', onConnect);
      connection!.addOrbListener('event', onEvent);
      connection!.addOrbListener('eventStream', onEventStream);
      connection!.connect();
      botConnection!.connect('empty');
    });
  }

  void onConnect({required EventStream eventStream,}) {
    connection?.firstConnect = false;
    setState(() {
      this.eventStream = eventStream;
    });
  }

  void onEvent({required EventStream eventStream, required AppEvent event}) {
    setState(() {
      this.eventStream = eventStream;
    });
    if (event.id == ActorData.userID) {
      botConnection?.getBot(event);
      return;
    }
  }

  void onEventStream({required EventStream eventStream}) {
    setState(() {
      this.eventStream = eventStream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: AppThemeProvider(
        child: AppMaterialProvider(
          eventStream: eventStream,
          connection: connection,
          botConnection: botConnection,
        )
      )
    );
  }
}

class AppMaterialProvider extends StatelessWidget {
  final EventStream? eventStream;
  final AppConnection? connection;
  final BotConnection? botConnection;
  AppMaterialProvider({required this.eventStream, required this.connection, required this.botConnection});

  @override
  Widget build(BuildContext context) {
    // connection!.connect();
    return MaterialApp(
      theme: AppTheme.of(context).themeData(),
      home: eventStream != null ? MyHomePage(eventStream: eventStream!, connection: connection!, botConnection: botConnection!,): const AppSplash(),
      builder: AppTheme.of(context).builder,
    );
  }
}

class AppSplash extends StatelessWidget {
  const AppSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
}

class MyAppState extends ChangeNotifier {
  var selectedIndex = 0;

  void onItemTapped(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {

  final EventStream eventStream;
  final AppConnection connection;
  final BotConnection botConnection;
  MyHomePage({required this.eventStream, required this.connection, required this.botConnection});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Widget page;
    switch (appState.selectedIndex) {
      case 0:
        page = MessagePage(eventStream: widget.eventStream, appState: appState, connection: widget.connection,);
        break;
      case 1:
        page = KnowledgeBasePage(appState: appState, connection: widget.connection,);
        break;
      case 2:
        page = SettingsPage(appState: appState, connection: widget.connection, botConnection: widget.botConnection,);
        break;
      default:
        throw UnimplementedError('no widget for ${appState.selectedIndex}');
    }

    return Scaffold(
      body: page,
    );
  }
}

