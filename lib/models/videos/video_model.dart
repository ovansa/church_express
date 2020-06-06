class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String publishedAt;
  final String description;

  VideoModel({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.publishedAt,
    this.description
  });

  factory VideoModel.fromMap(Map<String, dynamic> snippet) {
    return VideoModel(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      publishedAt: snippet['publishedAt'],
      description: snippet['description'],
    );
  }
}