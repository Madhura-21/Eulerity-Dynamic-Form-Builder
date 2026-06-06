# Eulerity-Dynamic-Form-Builder by Madhura 

Overview

This project is a Dynamic Form Builder built using SwiftUI and MVVM architecture. The application demonstrates a Server-Driven UI (SDUI) approach where the entire form structure, styling, validation rules, and component ordering are driven by a local JSON payload rather than hardcoded UI components.

The goal of this exercise was to build a scalable and resilient form rendering engine capable of dynamically generating UI based on backend-provided configurations while maintaining clean architecture, extensibility, and robust validation.

Features
Dynamic Form Rendering

The application dynamically renders form components based on the JSON configuration.

Supported Components:

TEXT
PLAIN
MULTILINE
NUMBER
URI
SECURE
DROPDOWN
Single Select
Multi Select
TOGGLE
CHECKBOX
Global Theming

The application supports dynamic theming through JSON:

Background Color
Text Color
Border Color
Error Color
Validation Engine

Supports:

Required Field Validation
Character Limit Validation
Regex Validation (Optional Enhancement)
Inline Error Messages
Form Submission Validation
Defensive Parsing

The application safely handles unknown field types.

Example:

{
  "type": "DATE_PICKER"
}

Unknown components are ignored without crashing the application.

Dynamic Ordering

Fields are rendered using the order property rather than relying on JSON array positions.

Offline Support

The application loads data from a bundled JSON file and performs no network requests.

Architecture

The project follows the MVVM (Model-View-ViewModel) architecture pattern.

Benefits:

Clear separation of concerns
Improved testability
Better scalability
Easier maintenance
Reusable UI components
Architecture Diagram
                  ┌────────────────────┐
                  │     form.json      │
                  └─────────┬──────────┘
                            │
                            ▼
                  ┌────────────────────┐
                  │    JSONLoader      │
                  └─────────┬──────────┘
                            │
                            ▼
                  ┌────────────────────┐
                  │       Models       │
                  │ Theme / Fields     │
                  └─────────┬──────────┘
                            │
                            ▼
                  ┌────────────────────┐
                  │   FormViewModel    │
                  │ State + Validation │
                  └─────────┬──────────┘
                            │
                            ▼
                  ┌────────────────────┐
                  │ SwiftUI Components │
                  └────────────────────┘
Project Structure
DynamicFormBuilder
│
├── App
│   └── DynamicFormBuilderApp.swift
│
├── Core
│   ├── Extensions
│   │   ├── Color+Hex.swift
│   │   └── String+Validation.swift
│   │
│   ├── Utilities
│   │   ├── ValidationEngine.swift
│   │   └── Constants.swift
│   │
│   └── Theme
│       └── ThemeEnvironment.swift
│
├── Models
│   ├── FormResponse.swift
│   ├── Theme.swift
│   ├── Field.swift
│   ├── FieldType.swift
│   ├── TextSubtype.swift
│   ├── DropdownOption.swift
│   └── FieldValue.swift
│
├── Services
│   └── JSONLoader.swift
│
├── ViewModels
│   └── FormViewModel.swift
│
├── Views
│   ├── FormScreen.swift
│   │
│   └── Components
│       ├── DynamicFieldView.swift
│       ├── TextFieldComponent.swift
│       ├── DropdownComponent.swift
│       ├── ToggleComponent.swift
│       ├── CheckboxComponent.swift
│       └── ValidationMessageView.swift
│
├── Resources
│   └── form.json
│
├── Tests
│   ├── DecoderTests.swift
│   ├── ValidationTests.swift
│   └── ThemeTests.swift
│
├── README.md
│
└── AI_COLLABORATION_LOG.md
Approach
1. JSON-Driven Architecture

Instead of building a static form, the application reads a JSON configuration file and generates the UI dynamically.
