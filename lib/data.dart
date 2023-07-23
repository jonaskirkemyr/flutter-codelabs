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
}
