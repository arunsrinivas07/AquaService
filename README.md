# RoWater - Aqua Service Management System

RoWater (Aqua Service) is a professional, production-grade Flutter application designed for managing reverse osmosis (RO) water purification services. The app provides a seamless experience for both service providers (admins) and consumers (customers), streamlining service requests, machine maintenance, payment tracking, and overall management.

## 🚀 Vision

To provide a robust and scalable platform that ensures high-quality water service management through real-time tracking, efficient scheduling, and transparent communication.

---

## 🏗️ Project Architecture

The project follows a **Feature-First Architecture**, ensuring high modularity, maintainability, and scalability. This structure separates the codebase into distinct features, making it easier for teams to work on different parts of the application simultaneously.

### Directory Structure

```text
ro_water/
├── android/            # Android-specific configuration and code
├── ios/                # iOS-specific configuration and code
├── assets/             # Static assets like images and fonts
│   └── images/         # App icons, illustrations, and images
├── lib/
│   ├── main.dart       # Application entry point
│   ├── app.dart        # Main app configuration (MaterialApp, Theme, etc.)
│   ├── core/           # Shared components and utilities
│   │   └── widgets/    # Reusable UI components (buttons, cards, etc.)
│   └── features/       # Modular features of the application
│       ├── auth/       # Authentication, Login, Splash, and Language Selection
│       ├── admin/      # Admin dashboard, Customer management, and Service hubs
│       ├── customer/   # Customer portal, Service scheduling, and History
│       └── payment/    # Payment dues, Overviews, and Transaction handling
├── test/               # Unit and Widget tests
└── pubspec.yaml        # Project dependencies and configuration
```

---

## ✨ Key Features

### 👤 User Authentication & Onboarding
- **Multilingual Support**: Language selection for localized user experience.
- **Secure Login**: Access control for different user roles.
- **Splash Screen**: Professional branding upon app launch.

### 🛠️ Admin Dashboard
- **Management Hub**: Centralized control for service plans and complaints.
- **Customer Directory**: Comprehensive list and map view of all customers.
- **Activity Logs**: Detailed archival of system operations.
- **Approval System**: Workflow for appointment and service approvals.

### 📱 Customer Portal
- **Service Scheduling**: Easy booking for machine maintenance.
- **Complaint Tracking**: Real-time updates on reported issues.
- **Machine Details**: Detailed information about the RO unit installed.
- **Service History**: Complete record of previous maintenance and repairs.

### 💳 Payment Management
- **Overview Dashboard**: Visual representation of financial status.
- **Dues Tracking**: Monitoring of pending payments.
- **Payment Selection**: Flexible payment options for users.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **UI Architecture**: Feature-First / Clean Architecture principles
- **Maps**: [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter) for customer location tracking
- **Theming**: Custom Cyber-cyan Material 3 design system

---

## 📥 Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/ro_water.git
    cd ro_water
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the application**:
    ```bash
    flutter run
    ```

---

## 🤝 Contribution

This project is structured for collaborative development. Please follow the feature-first pattern when adding new functionality and ensure that reusable widgets are placed in the `core/widgets` directory.

---

## 📄 License

This project is private and intended for internal use only.
