import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EventModel {
  final String event_title;
  final String event_details;
  final String event_organization;
  final String event_date;
  final String event_link;
  final String event_image;
  final String event_location;
  EventModel({
    required this.event_title,
    required this.event_details,
    required this.event_organization,
    required this.event_date,
    required this.event_link,
    required this.event_image,
    required this.event_location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event_title': event_title,
      'event_details': event_details,
      'event_organization': event_organization,
      'event_date': event_date,
      'event_link': event_link,
      'event_image': event_image,
      'event_location': event_location,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      event_title: map['event_title'] as String,
      event_details: map['event_details'] as String,
      event_organization: map['event_organization'] as String,
      event_date: map['event_date'] as String,
      event_link: map['event_link'] as String,
      event_image: map['event_image'] as String,
      event_location: map['event_location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
