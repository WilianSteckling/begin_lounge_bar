import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  // Inicialização com o novo modelo, que possui todos os campos
  UserModel _user = const UserModel(
    name: 'Maria Costa', 
    username: '@mariacosta', 
    company: 'Tech Innovations Ltda', 
    sector: 'Tecnologia', 
    about: 'Apaixonada por gastronomia e networking. Sempre em busca de novas experiências culinárias e conexões profissionais significativas.', 
    whatsapp: '5549982001200',
    image: 'https://i.pravatar.cc/150?img=32', // URL Mock
    memberSince: 'Janeiro 2024',
  );
  
  // Dados de Fidelidade (Dados que são editados diretamente no Provider)
  final String _memberId = 'MC-2024-340';
  int _currentStamps = 12;

  // --- GETTERS & MÉTODOS ---
  UserModel get user => _user;
  String get memberId => _memberId; 
  int get currentStamps => _currentStamps; 

  // Método de atualização de perfil (adaptado do código React)
  void updateUser(Map<String, dynamic> newData) {
    _user = _user.copyWith(
      name: newData['name'] as String?,
      username: newData['username'] as String?, 
      company: newData['company'] as String?,
      sector: newData['sector'] as String?,
      about: newData['about'] as String?,
      whatsapp: newData['whatsapp'] as String?,
      image: newData['image'] as String?,
    );
    notifyListeners();
  }

  // MÉTODOS DE FIDELIDADE
  void addStamp() { 
    if (_currentStamps < 20) {
      _currentStamps++;
      notifyListeners();
    }
  }
  
  void resetStamps() { 
    _currentStamps = 0;
    notifyListeners();
  }
}
