class Activity {
  String? id;
  String? caption;
  String? city;
  String? venue;
  String? startDate;
  String? endDate;
  String? imageFile;
  String? introduction;
  String? youtubeLink;

  Activity(
      {this.id,
      this.caption,
      this.city,
      this.venue,
      this.startDate,
      this.endDate,
      this.imageFile,
      this.introduction,
      this.youtubeLink});

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
      id: json["ID"] as String?,
      caption: json["Caption"] as String?,
      city: json["City"] as String?,
      venue: json["Venue"] as String?,
      startDate: json["StartDate"] as String?,
      endDate: json["EndDate"] as String?,
      imageFile: json["ImageFile"] as String?,
      introduction: json["Introduction"] as String?,
      youtubeLink: json["YoutubeLink"] as String?);
}
