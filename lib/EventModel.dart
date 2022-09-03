class Alarm{
  late final int id;
  late final String name;
  late final String description;
  late final String time;

  Alarm({required this.time,required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id,'name': name, 'description': description,'time': time};
  }

  Alarm.fromMap(Map<String, dynamic> result)
      : id = result['id'],
        name = result['name'],
        description = result['password'],
        time = result['time'];
}