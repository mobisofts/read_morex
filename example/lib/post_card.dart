import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:read_morex/read_morex.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.userName, required this.content}) : super(key: key);

  final String userName;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: const Icon(CupertinoIcons.person_alt),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(userName, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text('4 minutes ago', style: TextStyle(fontSize: 10, color: Colors.black45)),
              ),
              const Icon(Icons.more_horiz_rounded)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReadMoreX(
                    content,
                    textStyle: const TextStyle(fontSize: 18),
                    readMoreColor: Colors.green,
                    filterContent: true,
                    fontWeightLabel: FontWeight.normal,
                    customFilter: <ReadMoreXPattern>[
                      ReadMoreXPattern(
                        pattern: r'github.com',
                        valueChanged: (value) => value?.replaceFirst('https://github.com/', 'Github '),
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Number $value')),
                          );
                        },
                      ),
                      ReadMoreXPattern(
                        pattern: r'https://',
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Link $value')),
                          );
                        },
                      ),
                      ReadMoreXPattern(
                        pattern: r'\b[0-9]{9,}\b',
                        colorChanged: Colors.red,
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Number $value')),
                          );
                        },
                      ),
                      ReadMoreXPattern(
                        pattern: r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
                        colorChanged: Colors.deepPurple,
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Email $value')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(text: 'Liked by '),
                  TextSpan(text: 'You ', style: TextStyle(fontWeight: FontWeight.w600)),
                  TextSpan(text: 'and '),
                  TextSpan(
                    text: '99 Others',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const Row(
            children: <Widget>[
              Icon(CupertinoIcons.ellipses_bubble, size: 20),
              SizedBox(width: 8),
              Icon(
                CupertinoIcons.heart_fill,
                color: Colors.green,
                size: 22,
              ),
              SizedBox(width: 8),
              Icon(Icons.send_rounded, size: 20),
              Expanded(
                child: Text(
                  '63 Comments',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}