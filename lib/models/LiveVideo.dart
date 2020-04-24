class LiveVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  LiveVideo({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
  });

  factory LiveVideo.fromMap(Map<String, dynamic> snippet) {
    return LiveVideo(
      id: snippet['id']['videoId'],
      title: snippet['snippet']['title'],
      thumbnailUrl: snippet['snippet']['thumbnails']['high']['url'],
      channelTitle: snippet['snippet']['channelTitle'],
    );
  }
}