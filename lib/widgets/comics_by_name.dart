
import 'package:flutter/cupertino.dart';

class ComicsByName extends StatefulWidget {
  const ComicsByName({super.key, required this.comics});

  //parametro
  final List comics;

  @override
  State<ComicsByName> createState() => _ComicsByNameState();
}

class _ComicsByNameState extends State<ComicsByName> {
  @override
  Widget build(BuildContext context) {
    return Text("lista de comics por nombre");
  }
}
