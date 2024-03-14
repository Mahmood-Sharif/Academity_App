import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const SectionCard({Key? key, required this.title, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: const Color(0xFFE6E6E6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(),
            ...items.map(
              (item) {
                return ListTile(
                  leading: Icon(item['icon'] as IconData),
                  title: Text(item['title'] as String),
                  onTap: item.containsKey('onTap')
                      ? item['onTap'] as void Function()?
                      : () {
                          // Default onTap action if not specified
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${item['title']} clicked')));
                        },
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
