# 🛒 LuxeMart – Supermarket Mobile Application

**LuxeMart** is a feature-rich supermarket **mobile app** built with **Flutter** and powered by **Firebase**, offering a smart and convenient shopping experience for customers. The app includes cart management, real-time promotions, store location tracking, and secure payments via Stripe.

---

## 📱 Features

- 🛍️ **Add to Cart & Favorites**  
  Easily browse and manage your shopping list with favorites and cart functionality.

- 📄 **Product Descriptions**  
  View detailed information about each product to make informed purchases.

- 📍 **Google Maps Integration**  
  Locate the nearest LuxeMart supermarket using real-time location services.

- 🔔 **Push Notifications (Geo-based)**  
  Registered users receive automatic push notifications for deals and promotions when they are within **200 meters** of a store, using **geofencing** powered by Firebase Cloud Messaging.

- 💳 **Stripe Payment Gateway**  
  Secure and seamless checkout with Stripe integration.

---

## 🛠️ Tech Stack

- **Frontend:** Flutter  
- **Backend & Services:** Firebase (Auth, Firestore, Cloud Functions, FCM)  
- **Maps & Location:** Google Maps API, Geofencing  
- **Payments:** Stripe API

---

## 🔐 Admin Portal (Web)

A separate **web-based admin portal** enables staff to:
- Manage products and categories
- Create and schedule promotions
- Track orders and user activity

> Note: The web admin is not part of this repo. Please refer to the [LuxeMart Admin Portal](#) (link to admin repo if available).

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version >= 3.0.0)
- Firebase project setup
- Stripe account with test API keys

### Clone the Repository

```bash
git clone https://github.com/pawan-kavinda/LUXEMART-supermarket-application.git
cd project
flutter pub get
