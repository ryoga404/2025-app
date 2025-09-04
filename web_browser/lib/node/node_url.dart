import 'node.dart';

class NodeWithURL extends Node {
  final String url;

  NodeWithURL(this.url,String name,[Node? parent]) : super(name,parent);
}