
📱 Java Quiz App

Une application mobile de quiz Java développée avec Flutter (frontend) et Spring Boot (backend REST), connectée à une base de données MongoDB.

---

🧰 Technologies

- Flutter (MVVM)
- Spring Boot (REST API)
- MongoDB (NoSQL)

---

🚀 Étapes pour lancer le projet

1. Télécharger project.zip


---

2. Lancer le serveur Backend (Spring Boot)

🔧 Prérequis :
- Java 17+
- Maven



L’API sera disponible à l’adresse suivante :
    http://Your_api:3000/api
 

---

3. Configurer le Frontend Flutter

📁 Fichiers à modifier :
- lib/services/quiz_service.dart
- lib/viewmodels/result_viewmodel.dart

🛠️ Exemple de modification :

    const String _baseUrl = "http://Your_api:3000/api";

Assure-toi que le téléphone ou l’émulateur Flutter est connecté au même réseau local que l'adresse IP du backend.

---

4. Lancer l'application Flutter
	🔧 Prérequis :
	Flutter SDK
	Dart SDK (inclus avec Flutter)
	Android Studio (ou VS Code avec extensions Flutter et Dart)
	Android Emulator ou un appareil physique connecté



    cd Quiz-app
    flutter pub get
    flutter run

---

📡 Endpoints utiles

- GET /api/questions → Liste des questions
- POST /api/results → Soumettre un résultat
- GET /api/results →Liste des results
---


---


