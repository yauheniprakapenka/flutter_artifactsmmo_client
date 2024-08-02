class DestinationDto {
  final String name;
  final int x;
  final int y;
  final dynamic content;

  const DestinationDto({
    required this.name,
    required this.x,
    required this.y,
    this.content,
  });

  factory DestinationDto.fromJson(Map<String, dynamic> json) {
    return DestinationDto(
      name: json['name'],
      x: json['x'],
      y: json['y'],
      content: json['content'],
    );
  }
}
