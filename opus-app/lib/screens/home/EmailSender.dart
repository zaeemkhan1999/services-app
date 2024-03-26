import 'dart:async';

import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

class EmailSender extends StatefulWidget {
  const EmailSender({Key key}) : super(key: key);

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Send Email",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenSizeConfig.safeBlockHorizontal * 5),
        ),
        backgroundColor: SColors.PrimaryColorPurple,
        flexibleSpace: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: _inkwells(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            CheckboxListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              title: Text('HTML'),
              onChanged: (bool value) {
                if (value != null) {
                  setState(() {
                    isHTML = value;
                  });
                }
              },
              value: isHTML,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < attachments.length; i++)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            attachments[i],
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => {_removeAttachment(i)},
                        )
                      ],
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: _openImagePicker,
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: send,
                          child: Icon(
                            Icons.send,
                            color: SColors.PrimaryColorPurple,
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    PickedFile pick = await picker.getImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        attachments.add(pick.path);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Widget _inkwells() {
    return Container(
      color: SColors.PrimaryColorPurple,
      child: Row(
        children: [
          Container(
            // width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 6,
                  0,
                  0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenSizeConfig.safeBlockHorizontal * 5, 0, 0),
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.25,
                        width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: ScreenSizeConfig.safeBlockHorizontal * 6),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
