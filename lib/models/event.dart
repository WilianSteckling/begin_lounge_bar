import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String imageUrl;
  final DateTime date;
  final String type; // Ex: 'Evento', 'Promoção', 'Em Breve'

  const EventModel({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.date,
    required this.type,
  });

  // Construtor para criar um EventModel a partir de um DocumentSnapshot do Firestore
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Converte Timestamp do Firestore para DateTime do Dart
    DateTime eventDate;
    if (data['date'] is Timestamp) {
      eventDate = (data['date'] as Timestamp).toDate();
    } else {
      // Fallback para strings ou outros formatos, se necessário
      eventDate = DateTime.now(); 
    }

    return EventModel(
      id: doc.id,
      tag: data['tag'] ?? '',
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      // Em um projeto real, 'imageUrl' seria um link do Firebase Storage
      imageUrl: data['imageUrl'] ?? 'https://placehold.co/600x400/1E1E1E/AF9164?text=SEM+IMAGEM',
      date: eventDate,
      type: data['type'] ?? 'Evento',
    );
  }

  // Método para converter o modelo para o formato JSON que o Firestore usa
  Map<String, dynamic> toFirestore() {
    return {
      'tag': tag,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date), // Salva como Timestamp
      'type': type,
    };
  }
}