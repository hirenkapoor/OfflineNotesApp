# OfflineNotesApp

OfflineNotesApp is an iOS application for managing notes with offline capabilities. It allows users to sign up, log in, create, view, and manage notes with attached photos. The app leverages Core Data for local persistence and follows Clean Architecture principles with MVVM for a scalable, maintainable, and testable codebase.

---

## 🧱 Architecture Overview

The app is structured into distinct layers adhering to Clean Architecture combined with MVVM, ensuring separation of concerns:

| Layer         | Responsibility                                                      | Folder                     |
|---------------|-------------------------------------------------------------------|----------------------------|
| Presentation  | UI components (SwiftUI Views) and ViewModels that bind data and handle user interaction | `Presentation/Views`, `ViewModels` |
| Domain        | Core business logic: Entities representing domain models and Use Cases containing application-specific logic | `Domain/Entities`, `Domain/UseCases` |
| Data          | Data management: Repositories abstracting Core Data, mappers translating between domain and storage models | `Data/Repository`, `Data/ModelEntityMappers` |
| Core          | Shared utilities: Dependency Injection container, Core Data stack, routing, and helper utilities | `Core/`                    |

### Data Flow
SwiftUI View → ViewModel → Use Case → Repository → Data Sources (Core Data)
---

## 🚀 Features

- **User Authentication**  
  Signup and login functionality with local persistence

- **Note Management**  
  Create new notes with photos  
  View list of saved notes  
  Detailed view of notes including photos

- **Offline Support**  
  Full offline capability with Core Data persistence

- **Reactive UI**  
  SwiftUI and Combine enable seamless UI updates based on state changes

- **Modular and Scalable Codebase**  
  Separation of concerns enables easy maintainability and future extensions

- **Dependency Injection**  
  Centralized DI container for managing dependencies and enhancing testability

---

## 📁 Folder Structure

OfflineNotesApp/
- Core/ # DI container, Core Data stack, utilities
- Data/ # Repositories, data sources, mappers
- Domain/ # Entities (NoteEntity, UserEntity), Use Cases
- Presentation/ # SwiftUI Views, ViewModels, UI components
- OfflineNotesApp.swift # App entry point

---

## 🔍 Core Components

### Domain Layer
- **Entities:**  
  `NoteEntity.swift`: Defines the Note domain model (title, content, date, photos)  
  `UserEntity.swift`: Defines the User domain model  
  `PhotoEntity.swift`: Represents photos attached to notes

- **Use Cases:**  
  `LoginUseCase.swift`: Handles user login logic  
  `SignupUseCase.swift`: Handles user registration  
  `FetchNotesUseCase.swift`: Retrieves stored notes  
  `AddNoteUseCase.swift`: Adds new notes with photos

### Data Layer
- **Repositories:**  
  Abstract interaction with Core Data and provide clean API for use cases.

- **Model Mappers:**  
  Convert between Core Data managed objects and domain entities bidirectionally.

### Presentation Layer
- **Views:**  
  Authentication screens (Login, Signup)  
  Notes List screen (`HomeView`)  
  Add Note screen (`AddNoteView`)  
  Note Detail screen (`NoteDetailView`)

- **ViewModels:**  
  Handle user input, business logic invocation, and state updates for each screen.

### Core Layer
- **DIContainer.swift:**  
  Centralized Dependency Injection managing all app services.

- **CoreDataStack.swift:**  
  Sets up Core Data stack and manages persistent container lifecycle.

- **Utilities:**  
  Photo picker, routing, hashing utilities, and validation helpers.

---

## 🛠 Technologies Used

- SwiftUI for declarative UI  
- Combine for reactive state management  
- MVVM + Clean Architecture for modularity and separation of concerns  
- Core Data for offline persistence  
- Swift Concurrency (async/await) for asynchronous code  
- Dependency Injection for decoupled, testable components  

---

## ⚙️ Setup Instructions

1. Downalod the repository  
2. Open `OfflineNotesApp.xcodeproj` in Xcode 14 or later  
3. Build and run the app on a simulator or physical device  
4. Use the signup screen to create an account or log in  
5. Start creating and managing notes offline, including adding photos  

---

## 📝 Usage Flow

- **Authentication:**  
  User signs up or logs in. ViewModels communicate with use cases to authenticate and persist user info locally.

- **Notes Management:**  
  After authentication, the Home screen fetches notes via `FetchNotesUseCase`. User can add notes (with photos) using `AddNoteView`. Notes are saved locally in Core Data.

- **Offline Operation:**  
  All notes and user data are stored locally, enabling full app functionality without internet access.

---

## 🛡 Testing & Extensibility

- Use Cases and Repositories are designed for easy unit testing.  
- DI container allows mocking dependencies for isolated tests.  
- Modular design supports future features like syncing with remote servers.

---

## 👨‍💻 Author

**Hiren Kapoor**  
Date Created: August 10, 2025

---
