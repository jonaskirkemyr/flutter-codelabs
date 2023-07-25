import "package:flutter/material.dart";
import "package:github/github.dart";
import "package:intl/intl.dart";

class GitHubStarCounter extends StatefulWidget {
  final String repositoryName;

  const GitHubStarCounter({
    required this.repositoryName,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _GitHubStarCounterState();
}

class _GitHubStarCounterState extends State<GitHubStarCounter> {
  // api client
  late GitHub github;

  Repository? repository;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    github = GitHub();
    fetchRepository();
  }

  @override
  void didUpdateWidget(GitHubStarCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update repository info when repositoryName changes
    if (widget.repositoryName == oldWidget.repositoryName) {
      return;
    }

    fetchRepository();
  }

  Future<void> fetchRepository() async {
    setState(() {
      repository = null;
      errorMessage = null;
    });

    if (widget.repositoryName.isNotEmpty) {
      try {
        var repo = await github.repositories
            .getRepository(RepositorySlug.full(widget.repositoryName));

        setState(() {
          repository = repo;
        });
      } on RepositoryNotFound {
        setState(() {
          repository = null;
          errorMessage = "${widget.repositoryName} not found";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.headlineMedium?.apply(color: Colors.green);
    final errorStyle = textTheme.bodyMedium?.apply(color: Colors.red);
    final numberFormat = NumberFormat.decimalPattern();

    if (errorMessage != null) {
      return Text(errorMessage!, style: errorStyle);
    }

    if (widget.repositoryName.isNotEmpty && repository == null) {
      return const Text("Loading");
    }

    if (repository == null) {
      // return empty widget if noo repositoryName is provided
      return const SizedBox();
    }

    return Text(
      numberFormat.format(repository!.stargazersCount),
      style: textStyle,
    );
    throw UnimplementedError();
  }
}
