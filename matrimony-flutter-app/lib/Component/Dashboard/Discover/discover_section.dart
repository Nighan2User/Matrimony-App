import 'package:flutter/material.dart';

class DiscoverSection extends StatelessWidget {
  const DiscoverSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
            (index) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text('Discover Match ${index + 1}'),
            subtitle: const Text('Age: 26 | Designer | Mumbai'),
            trailing: const Icon(Icons.favorite_border),
          ),
        ),
      ),
    );
  }
}
