import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ListGift extends StatelessWidget {
  ListGift({Key key, this.data}) : super(key: key);
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      //krijimi i harkut lart te kartave
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(16.0),
      ),
      child: InkWell(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new ClipRRect(
                child: Image.network(
                  data['imagelink'] ??
                      'https://www.computerhope.com/jargon/e/error.gif:',
                  height: 160,
                  width: 240,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: new Radius.circular(16.0),
                  bottomRight: new Radius.circular(16.0),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['titull'].toUpperCase(),
                      style: Theme.of(context).textTheme.title,
                    ),
                    new SizedBox(
                      height: 16.0,
                    ),
                    new Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, //hapsir midis tekstit
                      children: <Widget>[
                        //new Text(),
                        new Text(data['subtitle']),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            _poup(context);
          }),
    );
  }

  void _poup(BuildContext context) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateGift,
    );
    popup.show(
      title: Text(
        data['titull'].toUpperCase(),
      ),

      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(data['subtitle']),
            QrImage(
              padding:
                  new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              data:"446455", //(data['qr-code']),
              version: QrVersions.min,
              size: 200.0,
              
            ),
          ],
        ),
      ),
      // Text(data['subtitle']),

      actions: [
        popup.button(
          label: 'Close',
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
