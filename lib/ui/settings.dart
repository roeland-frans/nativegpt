import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../connection.dart';
import 'package:testtextapp/app.dart';
import 'package:testtextapp/ui/presence/user_avatar.dart';
import '../event.dart';



class AdvancedSettingsWidget extends StatefulWidget {
  final AppConnection connection;
  final BotConnection botConnection;
  final MyAppState appState;

  AdvancedSettingsWidget({required this.connection, required this.botConnection, required this.appState});

  @override
  State<StatefulWidget> createState() => _AdvancedSettingsWidgetState();

}

class _AdvancedSettingsWidgetState extends State<AdvancedSettingsWidget> {
  final List<DropdownMenuEntry> beans = <DropdownMenuEntry>[];
  TextEditingController apiController = TextEditingController();
  List<String> items = ["None", "Faiss (local only)"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Vector Database",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.black
                ),
                Row(
                  children: [
                    Text("Provider"),
                    Padding(padding: const EdgeInsets.only(left: 80, top: 60),),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder()
                        ),
                        value: widget.appState.getProvider(),
                        items: items.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item)
                        )).toList(),
                        onChanged: (item) => setState(() => widget.appState.onProviderChange(item)),
                          // widget.appState.selectedProvider = item!

                      ),
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.only(bottom: 15),),
                Row(
                  children: [
                    Text("File Location"),
                    Padding(padding: const EdgeInsets.only(left: 54),),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'C:/user/[user]/nativegpt/[...]',
                        ),
                        controller: TextEditingController(),
                      )
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.only(bottom: 15),),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Indexer",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.black
                ),
                Row(
                  children: [
                    Text("Chunk size"),
                    Padding(padding: const EdgeInsets.only(left: 68, top: 60),),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(),
                      )
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.only(bottom: 15),),
                Row(
                  children: [
                    Text("Chunk overlap"),
                    Padding(padding: const EdgeInsets.only(left: 46),),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(),
                      )
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Text(
                    "LLMs",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Text(
                  "OpenAI",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Divider(
                    color: Colors.black
                ),
                Row(
                  children: [
                    Text("API key"),
                    Padding(padding: const EdgeInsets.only(left: 90, bottom: 60),),
                    SizedBox(
                        width: 250,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: apiController,
                        )
                    ),
                    Padding(padding: const EdgeInsets.only(right: 20)),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                        )
                      ),
                      onPressed: () {
                        widget.botConnection.updateKey(apiController.text);
                        // _eventEmitter.emit('apiKey', {#apiKey: apiController.text});
                      },
                      icon: Icon(Icons.check_box),
                      label: Text("Submit"),
                      // color: AppThemePalette.themeColorBase,
                    )
                  ],
                ),
                Text(
                  "Llama",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Divider(
                    color: Colors.black
                ),
                Row(
                  children: [
                    Text("Model Location"),
                    Padding(padding: const EdgeInsets.only(left: 42, bottom: 60),),
                    SizedBox(
                        width: 250,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(),
                        )
                    ),
                    Padding(padding: const EdgeInsets.only(right: 20)),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                        )
                      ),
                      onPressed: () {

                      },
                      icon: Icon(Icons.check_box),
                      label: Text("Submit"),
                      // color: AppThemePalette.themeColorBase,
                    )
                  ],
                ),
                Text(
                  "Vicuna 7b",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Divider(
                    color: Colors.black
                ),
                Row(
                  children: [
                    Text("Model Location"),
                    Padding(padding: const EdgeInsets.only(left: 42, bottom: 60),),
                    SizedBox(
                        width: 250,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(),
                        )
                    ),
                    Padding(padding: const EdgeInsets.only(right: 20)),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                        )
                      ),
                      onPressed: () {
                      },
                      icon: Icon(Icons.check_box),
                      label: Text("Submit"),
                      // color: AppThemePalette.themeColorBase,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
          ),
        ],
      ),
    );
  }
}

class GeneralSettingsWidget extends StatefulWidget {

  final AppConnection connection;
  final BotConnection botConnection;
  final MyAppState appState;

  GeneralSettingsWidget({required this.connection, required this.botConnection, required this.appState});

  @override
  State<StatefulWidget> createState() => _GeneralSettingsWidgetState();
}

class _GeneralSettingsWidgetState extends State<GeneralSettingsWidget> {

  final List<DropdownMenuEntry> beans = <DropdownMenuEntry>[];
  TextEditingController textController = TextEditingController();
  List<String> items = ["None", "Faiss (local only)"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(bottom: 15),),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Divider(
                  color: Colors.black
                ),
                Row(
                  children: [
                    Text("Avatar"),
                    Padding(padding: const EdgeInsets.only(left: 90, bottom: 60),),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          widthFactor: 40,
                          heightFactor: 40,
                          child: Image.network('https://picsum.photos/250?image=9'),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(right: 20)),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                        )
                      ),
                      onPressed: () {
                        // _eventEmitter.emit('apiKey', {#apiKey: apiController.text});
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Edit"),
                      // color: AppThemePalette.themeColorBase,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black
                ),
                Row(
                  children: [
                    Text("Username"),
                    Padding(padding: const EdgeInsets.only(left: 68, bottom: 60),),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: widget.appState.getName("user01"),
                          border: OutlineInputBorder(),
                        ),
                        controller: textController,
                      )
                    ),
                    Padding(padding: const EdgeInsets.only(right: 20)),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                        )
                      ),
                      onPressed: () {
                        widget.appState.onUsernameChange(textController.text);
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Edit"),
                      // color: AppThemePalette.themeColorBase,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
          ),
        ],
      ),
    );
  }
}

class DisplaySettingsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'App personalization settings go here',
        ),
      ],
    );
  }

}