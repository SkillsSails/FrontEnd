


class GithubInfo { 
  String userId;
  String username;
  String userUrl;
  List<String> repositories;
  int followers;
  int following;
  List<String> starredRepos;
  String id;

  GithubInfo({
      required this.userId,
      required this.username,
      required this.userUrl,
      required this.repositories,
      required this.followers,
      required this.following,
      required this.starredRepos,
      required this.id,
  });

  // Factory method to create a GithubInfo instance from a map (e.g., JSON)
  factory GithubInfo.fromMap(Map<String, dynamic> map) {
    return GithubInfo(
      userId: map['user_id'],
      username: map['username'],
      userUrl: map['user_url'],
      repositories: List<String>.from(map['repositories']),
      followers: map['followers'],
      following: map['following'],
      starredRepos: List<String>.from(map['starred_repos']),
      id: map['_id'],
    );
  }

  // Method to convert a GithubInfo instance to a map (e.g., JSON)
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'user_url': userUrl,
      'repositories': repositories,
      'followers': followers,
      'following': following,
      'starred_repos': starredRepos,
      '_id': id,
    };
  }
}