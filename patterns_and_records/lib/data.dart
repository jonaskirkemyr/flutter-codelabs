import "dart:convert";

const documentJSON = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';

class Document {
  final Map<String, Object?> _json;

  Document() : _json = jsonDecode(documentJSON);

  (String, {DateTime modified}) get metadata {
    if (_json
        case {
          "metadata": {
            "title": String title,
            "modified": String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified));
    }

    throw const FormatException("Unexpected JSON");
  }

  List<Block> getBlocks() {
    if (_json case {"blocks": List blocksJson}) {
      return [for (final blockJson in blocksJson) Block.fromJson(blockJson)];
    }

    throw const FormatException("Unexpected JSON format");
  }
}

class Block {
  final String type;
  final String text;

  Block(this.type, this.text);

  factory Block.fromJson(Map<String, dynamic> json) {
    if (json case {"type": final type, "text": final text}) {
      return Block(type, text);
    }
    throw const FormatException("Unexpected JSON format");
  }
}
