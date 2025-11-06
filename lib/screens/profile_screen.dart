import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // ImagePicker para seleção de imagens
import '../providers/user_provider.dart'; // UserProvider
import '../models/user.dart'; // Modelo de Usuário (Necessário criar este arquivo!)
import 'settings_screen.dart'; // Importação necessária para navegação
// import 'edit_profile_dialog.dart'; // NÃO PRECISA MAIS, POIS ESTÁ NOVO CÓDIGO

// Fallback mapping: define LucideIcons locally to map used names to Material Icons,
// so the file compiles even if the flutter_lucide package does not export LucideIcons.
class LucideIcons {
  static const IconData settings = Icons.settings;
  static const IconData camera = Icons.camera_alt;
  static const IconData edit2 = Icons.edit;
  static const IconData building2 = Icons.apartment;
  static const IconData briefcase = Icons.work;
  static const IconData messageCircle = Icons.message;
  static const IconData clock = Icons.access_time;
  static const IconData user = Icons.person;
}

// --- NOTA: O código original usava um modal. Aqui, usaremos um ElevatedButton para simular a edição no escopo local. ---

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Função que será passada para o IconButton na AppBar
  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch: Ouve mudanças no UserProvider
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    // Funções auxiliares para replicar as cores de tema do React/Shadcn
    final Color primaryTextColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.white : const Color(0xFF1a1a1a);
    final Color secondaryTextColor = Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFFb0b0b0) : const Color(0xFF6b6b6b);
    final Color cardBackgroundColor = Theme.of(context).brightness == Brightness.dark 
        ? const Color(0xFF2a2a28) : Colors.white; // dark:bg-[#2a2a28]

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          children: [
            // Header (bg-white dark:bg-[#2a2a28] com curva)
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 56, bottom: 32),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                children: [
                  // Top Bar (Perfil e Settings)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Perfil', style: TextStyle(fontSize: 18, color: primaryTextColor)),
                      IconButton(
                        icon: Icon(LucideIcons.settings, color: primaryTextColor, size: 24),
                        onPressed: () => _navigateToSettings(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Profile Info (Avatar, Nome, Botão Editar)
                  _buildProfileInfo(context, user),
                ],
              ),
            ),
            
            // Biography Section
            _buildBiographySection(context, user, primaryTextColor, secondaryTextColor, cardBackgroundColor),
            
            // Additional Info
            _buildAdditionalInfo(context, primaryTextColor, secondaryTextColor, cardBackgroundColor),
          ],
        ),
      ),
    );
  }
  
  // --- Widgets de Reconstrução do React ---
  
  // Replicando o Modal de Edição como um Dialog (com lógica de State local)
  void _showEditProfileDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => _EditProfileDialog(initialUser: user),
    );
  }

  // Widget para informações do Perfil (Avatar, Nome, Botão Editar)
  Widget _buildProfileInfo(BuildContext context, UserModel user) {
    final Color primaryTextColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.white : const Color(0xFF1a1a1a);
        
    final ImageProvider avatarImage = user.image.startsWith('http')
        ? NetworkImage(user.image) as ImageProvider
        : MemoryImage(Uri.parse(user.image).data!.contentAsBytes()); 

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 56,
              backgroundImage: avatarImage,
              backgroundColor: const Color(0xFFAF9164), // AvatarFallback bg-[#AF9164]
              child: user.image.isEmpty 
                ? Text(user.name.substring(0, 2).toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 24))
                : null,
            ),
            // Botão Câmera (simula upload/abertura do modal)
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () => _showEditProfileDialog(context, user),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42), // bg-[#FF8C42]
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                  ),
                  child: const Icon(LucideIcons.camera, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(user.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryTextColor)),
        ),
        Text(user.username, style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodySmall?.color)),

        // Edit Button (Dialog Trigger)
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ElevatedButton.icon(
            onPressed: () => _showEditProfileDialog(context, user),
            icon: const Icon(LucideIcons.edit2, size: 16, color: Colors.white),
            label: const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAF9164), // bg-[#AF9164]
              minimumSize: const Size(280, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  // Seção de Biografia
  Widget _buildBiographySection(BuildContext context, UserModel user, Color primary, Color secondary, Color cardBg) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Biografia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
          const SizedBox(height: 12),
          Card(
            color: cardBg,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem(context, LucideIcons.building2, 'Empresa', user.company, cardBg),
                  Divider(color: Theme.of(context).dividerColor),
                  _buildInfoItem(context, LucideIcons.briefcase, 'Setor', user.sector, cardBg),
                  Divider(color: Theme.of(context).dividerColor),
                  _buildInfoItem(context, LucideIcons.messageCircle, 'WhatsApp', user.whatsapp.isNotEmpty ? '+${user.whatsapp}' : 'Não informado', cardBg),
                  Divider(color: Theme.of(context).dividerColor),
                  
                  // Sobre mim
                  const SizedBox(height: 8),
                  Text('Sobre mim', style: TextStyle(fontSize: 14, color: secondary)),
                  const SizedBox(height: 4),
                  Text(user.about, style: TextStyle(fontSize: 15, color: primary, height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label, String value, Color cardBg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4EB), // bg-[#FFF4EB]
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFFF8C42), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodySmall?.color)),
                Text(value, style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyLarge?.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Seção de Informações Adicionais (Membro Desde)
  Widget _buildAdditionalInfo(BuildContext context, Color primary, Color secondary, Color cardBg) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
      child: Card(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4EB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.clock, color: Color(0xFFFF8C42), size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Membro desde', style: TextStyle(fontSize: 13, color: secondary)),
                  Text('Janeiro 2024', style: TextStyle(fontSize: 15, color: primary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Componente de Edição de Perfil (Modal/Dialog) ---

class _EditProfileDialog extends StatefulWidget {
  final UserModel initialUser;
  const _EditProfileDialog({required this.initialUser});

  @override
  State<_EditProfileDialog> createState() => __EditProfileDialogState();
}

class __EditProfileDialogState extends State<_EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late UserModel _localProfileData;
  final ImagePicker picker = ImagePicker(); // Necessário para ImagePicker (instale a dependência)
  
  // NOTE: Implementação de File upload no Flutter requer pacotes e libs.
  // Aqui, simularemos a atualização da imagem apenas pelo path ou URL.
  String? _newImagePath; 

  @override
  void initState() {
    super.initState();
    // Clona o usuário inicial para editar localmente
    _localProfileData = widget.initialUser.copyWith();
  }
  
  Future<void> _handleImageUpload() async {
    // Simula a lógica de upload de imagem do React
    // Em Flutter, você usaria image_picker
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _newImagePath = pickedFile.path;
      });
      // Em uma aplicação real, aqui você faria o upload e obteria a URL/Base64.
      // Por enquanto, atualizamos apenas o path.
    }
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      // Converte o path local para URL ou Base64 (simulando a atualização do React)
      String newImageUrl = _newImagePath ?? _localProfileData.image; 
      
      // Atualiza o Provider
      userProvider.updateUser({
        'name': _localProfileData.name,
        'username': _localProfileData.username,
        'company': _localProfileData.company,
        'sector': _localProfileData.sector,
        'about': _localProfileData.about,
        'whatsapp': _localProfileData.whatsapp,
        'image': newImageUrl, 
      });

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define a ImageProvider com base se há um novo arquivo local ou a URL existente
    final ImageProvider avatarImage = _newImagePath != null 
        ? FileImage(File(_newImagePath!)) as ImageProvider
        : NetworkImage(_localProfileData.image); 

    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      scrollable: true,
      title: Text('Editar Perfil', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Profile Image Upload
            _buildImageUpload(context, avatarImage),
            const SizedBox(height: 20),
            
            // Campos do Formulário
            _buildTextField(context, 'Nome', LucideIcons.user, _localProfileData.name, 
              (value) => _localProfileData = _localProfileData.copyWith(name: value)),
            _buildTextField(context, 'Empresa onde trabalha', LucideIcons.building2, _localProfileData.company, 
              (value) => _localProfileData = _localProfileData.copyWith(company: value)),
            _buildTextField(context, 'Setor da empresa', LucideIcons.briefcase, _localProfileData.sector, 
              (value) => _localProfileData = _localProfileData.copyWith(sector: value)),
            _buildTextField(context, 'WhatsApp', LucideIcons.messageCircle, _localProfileData.whatsapp, 
              (value) => _localProfileData = _localProfileData.copyWith(whatsapp: value), isWhatsApp: true),
            
            // About Me (Textarea)
            TextFormField(
              initialValue: _localProfileData.about,
              decoration: const InputDecoration(labelText: 'Sobre mim (Biografia)'),
              maxLines: 4,
              onSaved: (value) => _localProfileData = _localProfileData.copyWith(about: value)),

            const SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8C42), // bg-[#FF8C42]
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTextField(BuildContext context, String label, IconData icon, String initialValue, 
      void Function(String?) onSaved, {bool isWhatsApp = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.secondary),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onSaved: onSaved,
            validator: (value) => value!.isEmpty && !isWhatsApp ? '$label é obrigatório' : null,
          ),
          if (isWhatsApp) 
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 10.0),
              child: Text(
                'Formato: código do país + DDD + número (ex: 5549982001200)',
                style: TextStyle(fontSize: 11, color: Theme.of(context).textTheme.bodySmall?.color),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageUpload(BuildContext context, ImageProvider avatarImage) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: avatarImage,
                backgroundColor: const Color(0xFFAF9164),
                child: _localProfileData.image.isEmpty
                    ? Text(_localProfileData.name.substring(0, 2).toUpperCase(), style: const TextStyle(color: Colors.white))
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: _handleImageUpload,
                  child: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42),
                      shape: BoxShape.circle,
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                    ),
                    child: const Icon(LucideIcons.camera, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('Clique para trocar a foto', style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color)),
          ),
        ],
      ),
    );
  }
}
