# Eulerity-Dynamic-Form-Builder by Madhura 

# Dynamic Form Builder (Server-Driven UI)

A SwiftUI-based iOS application that demonstrates a **Server-Driven UI (SDUI)** architecture by dynamically generating forms from a JSON configuration file.

This project was built as part of the **Eulerity iOS Developer Take-Home Exercise** and showcases modern iOS development practices including SwiftUI, MVVM, polymorphic JSON decoding, dynamic theming, validation, and defensive programming.

---

## Features

### Dynamic Form Rendering

The entire form UI is generated from JSON configuration without hardcoded screens.

Supported field types:

* **TEXT**

  * Plain Text
  * Multiline Text
  * Number Input
  * URI Input
  * Secure Input

* **DROPDOWN**

  * Single Select
  * Multi Select

* **TOGGLE**

  * Boolean Toggle

* **CHECKBOX**

  * Standard Checkbox
  * Optional clickable metadata links

---

## Server-Driven UI (SDUI)

The backend configuration controls:

* Field Types
* Labels
* Display Order
* Validation Rules
* Required Fields
* Character Limits
* Dropdown Options
* Theme Colors

This allows new forms to be created or modified without changing application code.

---

## Dynamic Theming

Theme values are provided through JSON and applied across the application.

Example:

```json
{
  "background_color": "#FFFFFF",
  "text_color": "#111827",
  "border_color": "#D1D5DB",
  "error_color": "#B91C1C"
}
```

The application automatically updates:

* Background Colors
* Text Colors
* Border Colors
* Error States
* Accent Colors

---

## Validation

The form includes support for:

* Required Field Validation
* Character Limit Enforcement
* Dropdown Selection Validation
* Checkbox Validation
* Optional Regex Validation

Validation errors are displayed inline to provide clear user feedback.

---

## Defensive Parsing

Unknown field types are safely ignored.

Example:

```json
{
  "type": "DATE_PICKER"
}
```

Instead of crashing, the application skips unsupported components and continues rendering the remaining form.

This approach makes the system forward-compatible with future backend updates.

---

# Architecture

The project follows the MVVM (Model-View-ViewModel) architecture.

```text
DynamicFormBuilder
│
├── Models
├── Services
├── ViewModels
├── Views
├── Resources
└── Tests
```

## Models

Responsible for representing:

* Form Configuration
* Theme Configuration
* Field Definitions
* Dropdown Options
* Validation Metadata

Key files:

* FormResponse.swift
* Field.swift
* Theme.swift
* DropdownOption.swift

---

## Services

Responsible for:

* Loading JSON from Bundle
* Decoding Configuration
* Error Handling

Key file:

* JSONLoader.swift

---

## ViewModels

Responsible for:

* Form State Management
* Validation Logic
* Submission Handling
* Dynamic Value Storage

Key file:

* FormViewModel.swift

---

## Views

Responsible for:

* Dynamic UI Rendering
* User Interaction
* Component Presentation

Key files:

* FormScreen.swift
* DynamicFieldView.swift
* TextFieldComponent.swift
* DropdownComponent.swift
* ToggleComponent.swift
* CheckboxComponent.swift

---

# Project Structure

```text
DynamicFormBuilder/
│
├── App/
│   └── DynamicFormBuilderApp.swift
│
├── Models/
│   ├── FormResponse.swift
│   ├── Field.swift
│   ├── Theme.swift
│   └── DropdownOption.swift
│
├── Services/
│   └── JSONLoader.swift
│
├── ViewModels/
│   └── FormViewModel.swift
│
├── Views/
│   ├── FormScreen.swift
│   └── Components/
│
├── Resources/
│   └── form.json
│
├── Tests/
│   ├── DecoderTests.swift
│   └── ValidationTests.swift
│
├── README.md
└── AI_COLLABORATION_LOG.md
```

---

# Getting Started

## Requirements

* Xcode 16+
* Swift 5.10+
* iOS 16.0+
* macOS Sonoma or later

---

## Installation

### Clone the repository

```bash
git clone https://github.com/your-username/dynamic-form-builder.git
```

### Navigate into the project directory

```bash
cd dynamic-form-builder
```

### Open the project

```bash
open DynamicFormBuilder.xcodeproj
```

or

```bash
open DynamicFormBuilder.xcworkspace
```

---

## Run the Application

1. Open the project in Xcode.
2. Select an iOS Simulator.
3. Press:

```text
⌘ + R
```

4. The application will launch automatically.

---

# Configuration

The form configuration is loaded from:

```text
Resources/form.json
```

To modify the form:

1. Open `form.json`
2. Add, remove, or modify fields
3. Re-run the application

No code changes are required.

---

# Example Configuration

```json
{
  "id": "campaign_name",
  "type": "TEXT",
  "subtype": "PLAIN",
  "label": "Campaign Name",
  "required": true
}
```

---

# Using the Application

### 1. Launch the App

The application loads the JSON configuration and dynamically renders the form.

### 2. Fill Required Fields

Enter values for all required fields.

### 3. Submit

Tap the **Save** button.

### 4. Validation

If validation fails:

* Inline errors are displayed
* Missing required fields are highlighted

### 5. Successful Submission

A submission payload is generated and displayed.

Example:

```json
{
  "campaign_name": "Summer Sale",
  "ad_networks": [
    "net_meta"
  ],
  "daily_budget": "500"
}
```

---

# Testing

The project includes unit tests covering:

* JSON Decoding
* Polymorphic Parsing
* Validation Logic
* Theme Parsing
* Unknown Type Handling

Run tests using:

```text
⌘ + U
```

---

# Product Decisions

### 1. Ignore Unknown Component Types

Unknown field types are skipped rather than causing failures.

This ensures forward compatibility with future backend-driven UI updates.

### 2. Validation Occurs On Save

Validation is triggered when the user taps Save rather than during every keystroke.

This creates a less intrusive user experience.

### 3. Field Ordering Comes From JSON

The application sorts fields using the `order` property.

This allows the backend to control layout without requiring app updates.

---

# Future Improvements

Given additional time, the following enhancements would be implemented:

* Remote API-driven form configuration
* Accessibility improvements
* Localization support
* Snapshot testing
* Additional component types

  * Date Picker
  * Radio Button
  * Slider
  * Stepper
  * Image Picker
* Analytics and event tracking

---

# Challenges & Learnings

### Polymorphic JSON Decoding

One of the key challenges was decoding multiple field types from a single JSON array while maintaining type safety and extensibility.

### Dynamic State Management

The form supports multiple field value types and stores them dynamically while preserving validation and submission behavior.

### Defensive Programming

Special attention was given to handling:

* Unknown field types
* Missing optional fields
* Invalid configurations
* Empty dropdown options
* Malformed payloads

without causing application crashes.

---

# Contributing

Contributions are welcome.

## Steps to Contribute

### 1. Fork the Repository

```bash
git fork <repository-url>
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/new-component
```

### 3. Commit Changes

```bash
git commit -m "Add new component"
```

### 4. Push Changes

```bash
git push origin feature/new-component
```

### 5. Open a Pull Request

Submit a pull request with a clear description of the changes made.

---

## Contribution Guidelines

Please ensure:

* Code follows MVVM architecture
* SwiftLint warnings are resolved
* Unit tests pass
* New features include tests
* Public APIs are documented

---

# AI Collaboration

As required by the assignment, AI-assisted tools were used during development.

AI was leveraged for:

* Architecture brainstorming
* SwiftUI implementation guidance
* JSON decoding strategies
* Validation design discussions
* Code review and refinement

All generated code was reviewed, modified where necessary, tested, and fully understood before inclusion in the final solution.

---
