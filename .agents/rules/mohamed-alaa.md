---
trigger: always_on
---

# GEMINI.md

<!--
This file provides mandatory engineering rules and project architecture guidance
for Gemini when generating, modifying, or reviewing code in this repository.
-->

# Engineering Rules

## 1. Architecture (STRICTLY REQUIRED)

Follow Clean Architecture strictly:

presentation → domain → data

Rules:

* Never bypass layers
* Never mix responsibilities
* UI layer contains ZERO business logic
* Business logic belongs only in domain
* APIs, database, caching, and storage belong only in data layer
* Do not introduce unnecessary abstractions

---

## 2. Shared Code

Any reusable:

* utility
* extension
* helper
* widget
* constant
* service

used in 2+ places MUST go inside:

core/

Always check existing shared code before creating duplicates.

---

## 3. Error Handling

Rules:

* Handle loading, empty, error, and success states explicitly
* No silent failures
* Catch exceptions at data layer boundaries
* Map exceptions to typed Failure models
* Never throw raw exceptions to presentation layer

---

## 4. Change Discipline

Rules:

* Make the smallest safe change possible
* Fix root causes, not symptoms
* Avoid unrelated refactoring
* Preserve existing UX and APIs unless explicitly requested
* Read surrounding code before modifying anything

---

## 5. Dependencies

Rules:

* Do not add dependencies without justification
* Prefer stable, production-grade packages
* Avoid unnecessary packages

---

## 6. Security

Rules:

* Never hardcode API keys or secrets
* Never log sensitive information
* Validate all external input
* Flag potential security risks proactively

---

## 7. Testing

Rules:

* Write tests for domain and data layers
* Bug fixes must include reproducing tests
* Tests must be deterministic
* One behavior per test

---

# Flutter / Dart Rules

## 1. State Management

Use:

* Cubit
* Bloc

Do NOT use:

* Provider
* Riverpod
* GetX

Rules:

* Cubits depend ONLY on use cases
* No repository access directly inside Cubits
* setState allowed only for tiny local UI state

---

## 2. No Code Generation

Do NOT use:

* Freezed
* build_runner

Use Dart 3 features instead:

* sealed classes
* pattern matching
* records
* switch expressions

---

## 3. Domain Layer Purity

Rules:

* Domain layer must NEVER import Flutter
* No package:flutter imports inside domain/

---

## 4. Feature Structure

Use:

features/
feature_name/
data/
domain/
presentation/

---

## 5. Error Flow Contract

Data Layer:

* catch exceptions
* map to Failure types

Domain Layer:

* return ApiResult<T>

Presentation Layer:

* map failures to user-friendly UI states

---

## 6. Dependency Injection

Use:

* get_it

Rules:

* Single DI setup inside:
  core/di/

* Resolve:

  * Cubits
  * Use cases
  * Repositories

through get_it only

---

## 7. Build Method Rules

Rules:

* Prefer const constructors
* Never create controllers inside build()
* Avoid heavy computations in build()
* Dispose controllers properly
* Prefer small reusable widgets
* Use BlocBuilder only for minimal rebuild areas

Never create inside build():

* TextEditingController
* AnimationController
* FocusNode
* ScrollController

---

## 8. Widget Structure Rules

Rules:

* Do NOT separate UI sections using private widget methods like:

  * `_buildHeader()`
  * `_buildBody()`
  * `_buildSection()`

BAD:

```dart
Widget _buildHeader() {
  return Container();
}
```

Instead:

* Create separate reusable widget classes/files for every major UI section

GOOD:

```dart
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Preferred structure:

presentation/
widgets/
header_section.dart
skills_section.dart
projects_section.dart
contact_section.dart

Rules:

* Each UI section should be an independent widget
* Keep widgets small and composable
* Reusable UI belongs in shared widgets
* Avoid giant screen files
* Avoid deeply nested build methods
* Prefer stateless widgets when possible
* Private methods are allowed ONLY for tiny local UI pieces that are not reusable

---

# UI / UX Rules

Rules:

* Responsive on mobile, tablet, and web
* Use modern spacing and typography
* Prefer reusable widgets
* Keep animations smooth and lightweight
* Avoid deeply nested widget trees
* Follow accessibility best practices

---

# Portfolio Project Rules

Project uses:

* Flutter
* Clean Architecture
* Cubit/Bloc
* get_it
* Dio
* Firebase
* REST APIs

Portfolio sections:

* Hero
* About
* Skills
* Projects
* Experience
* Contact
* Footer

Featured projects:

* Quran Khatma App
* Hotel Booking App
* Real-time Chat App
* E-learning Platform

GitHub:
mohamedAlaa-CS

---

# Code Quality Expectations

Generated code MUST:

* be production-ready
* follow SOLID principles
* use clean naming
* avoid duplicated logic
* be scalable and maintainable
* follow Flutter best practices
* support responsive layouts
* support dark mode

---

# Important

Before generating code:

1. Analyze existing architecture
2. Reuse existing shared components
3. Avoid unnecessary complexity
4. Preserve architectural boundaries
5. Keep code readable and maintainable
