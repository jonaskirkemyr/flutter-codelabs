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
    if (_json.containsKey("metadata")) {
      final metadataJson = _json["metadata"];

      if (metadataJson is Map) {
        final title = metadataJson["title"];
        final localModified = DateTime.parse(metadataJson["modified"]);

        return (title, modified: localModified);
      }
    }

    throw const FormatException("Unexpected JSON");
  }
}
