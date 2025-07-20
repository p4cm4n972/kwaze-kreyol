# Kwazé Kréyol

> Une application mobile Flutter pour promouvoir le créole martiniquais 🌿

Kwazé Kréyol est une application ludique et culturelle développée avec Flutter (Material 3) et NestJS. Elle a pour objectif de faire découvrir, pratiquer et valoriser le créole martiniquais à travers plusieurs modules :

---

## 📉 Fonctionnalités principales

### 🌍 Traducteur créole
- Traduction de mots ou phrases du français vers le créole martiniquais (moteur local ou distant)
- Affichage de la traduction, d’un exemple d’usage

### 🎲 Jeux en créole
- **Scrabble créole** (prochainement)
- **Mots mélés** (avec interaction tactile)
- **Mots cassés** (prochainement)
- **Dominos** (prochainement)

### 💬 Sitasyon & Pawol Matinik
- Affichage aléatoire de citations ou proverbes populaires
- Ajout futur de favoris et partage

---

## 🛠️ Stack Technique

### Frontend
- Flutter (Material 3, responsive design)
- Authentification JWT (avec stockage local du token)
- Gestion offline possible (mode mock activable)

### Backend
- NestJS + MongoDB (en cours de déploiement)
- Authentification JWT
- Sauvegarde des parties, préférences utilisateur, etc.

---

## 📅 Roadmap

- [x] Authentification mock + JWT
- [x] Modules : traduction, jeux, sitasyon
- [ ] Backend NestJS (auth + sauvegarde)
- [ ] Mode hors-ligne complet
- [ ] Publication sur store (Android & iOS)

---

## 🎨 Thématique visuelle
- Inspiration : tissu madras, mer des Caraïbes, couleurs traditionnelles
- Palette personnalisée Flutter avec Material You

---

## 💡 Nom
**Kwazé Kréyol** signifie "La croisée créole" : A la croisée des savoirs, des générations, des médias pour faire vivre la langue.

---

## 🚀 Lancer le projet en local

```bash
git clone https://github.com/<ton-user>/kwaze-kreyol.git
cd kwaze-kreyol
flutter pub get
flutter run
