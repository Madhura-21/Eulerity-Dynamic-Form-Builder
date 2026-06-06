# README

## Dynamic Form Builder (Eulerity Take-Home)

### Overview

This project implements a fully dynamic, JSON-driven form builder using SwiftUI and MVVM architecture. The application renders its UI entirely from a local JSON file bundled with the app, allowing new forms, themes, validation rules, and field configurations to be introduced without modifying application code.

The solution emphasizes scalability, defensive parsing, maintainability, and production-grade architecture. All form elements are generated dynamically at runtime using Codable-based polymorphic decoding and SwiftUI composition.

---

## Architecture

The project follows the MVVM (Model-View-ViewModel) pattern.

### Models

Responsible for decoding and representing:

* Form metadata
* Theme configuration
* Dynamic fields
* Validation rules
* Dropdown options
* Field-specific configuration

Key models include:

* FormResponse
* Theme
* Field
* FieldType
* TextSubtype
* DropdownOption

### Service Layer

#### JSONLoader

Responsibilities:

* Load local JSON from Bundle
* Decode JSON safely
* Handle malformed payloads
* Return Result types
* Isolate decoding logic from UI

### ViewModel

#### FormViewModel

Responsibilities:

* Load form definitions
* Maintain field state
* Track validation errors
* Publish UI updates
* Generate submission payload
* Coordinate save actions

### Views

Views remain completely generic and data-driven.

The renderer:

1. Reads decoded field models
2. Sorts fields using `field.order`
3. Dynamically selects the appropriate SwiftUI component
4. Binds values back to the ViewModel

Supported field types:

* TEXT
* DROPDOWN
* TOGGLE
* CHECKBOX

Unknown field types are safely ignored.

---

## JSON Decoding Strategy

A polymorphic decoding strategy is used to support dynamic field rendering.

Each field contains a `type` property.

Examples:

```json
{
  "type": "TEXT"
}
```

```json
{
  "type": "DROPDOWN"
}
```

During decoding:

1. Type is decoded first.
2. Matching enum case is selected.
3. Type-specific properties are decoded.
4. Unsupported types fall back to `.unknown`.

Example:

```json
{
  "type": "DATE_PICKER"
}
```

Decodes successfully as:

```swift
case unknown
```

This prevents crashes when backend contracts evolve.

---

## Validation Strategy

Validation occurs when the user taps **Save**.

The validation engine supports:

* Required field validation
* Character limit enforcement
* Regex validation
* Toggle/checkbox validation
* Dropdown selection validation

Inline validation errors are displayed below the associated field.

If a custom error message exists:

```json
{
  "error_message": "Campaign name is required"
}
```

the custom message is used.

Otherwise a sensible default is generated:

```text
Campaign Name is required
```

Submission is blocked until all validations pass.

---

## Theme Engine

The application supports runtime theming using JSON configuration.

Example:

```json
{
  "background_color": "#FFFFFF",
  "text_color": "#111827",
  "border_color": "#D1D5DB",
  "error_color": "#B91C1C"
}
```

A custom `Color(hex:)` extension converts hex values into SwiftUI colors.

Theme values are applied dynamically to:

* Backgrounds
* Text
* Borders
* Validation states
* Accent colors
* Links

Missing values safely fall back to defaults.

---

# Product Decisions

Several implementation decisions were made that were not explicitly defined in the assignment.

## 1. Unknown Field Types Are Ignored

### Decision

Unsupported field types decode into:

```swift
case unknown
```

and are skipped during rendering.

### Why

Backend-driven forms often evolve independently from mobile releases.

Ignoring unsupported fields prevents crashes and allows the remainder of the form to function normally.

---

## 2. Validation Runs On Save Instead Of On Every Keystroke

### Decision

Validation is triggered when the user taps Save.

### Why

The assignment explicitly required validation on save.

Running validation continuously while typing can create a noisy experience, especially for required fields and regex validations.

This approach keeps the UI cleaner while still enforcing correctness before submission.

---

## 3. Missing Theme Values Fall Back Gracefully

### Decision

Theme properties are optional and fallback values are provided.

Example:

```swift
theme.errorColor ?? .red
```

### Why

Theme payloads are often incomplete during development.

Fallbacks ensure the application remains usable even when configuration is partially missing.

---

## 4. Character Limits Are Enforced During Input

### Decision

Text fields truncate values exceeding the configured max length.

### Why

Preventing invalid input early simplifies validation logic and provides immediate feedback to the user.

---

## What I Would Improve With More Time

### 1. Accessibility

Add:

* VoiceOver support
* Accessibility labels
* Accessibility hints
* Dynamic Type support

### 2. Localization

Move all user-facing strings into localized resources and support multiple languages.

### 3. Remote Configuration

Allow forms to be downloaded from an API while preserving offline support through caching.

### 4. Snapshot Testing

Add snapshot tests for:

* Light mode
* Dark mode
* Theme variations
* Validation states

### 5. Advanced Form Logic

Support:

* Conditional visibility
* Field dependencies
* Dynamic sections
* Computed values

### 6. Analytics

Track:

* Validation failures
* Field completion rates
* Form abandonment

### 7. Better Multi-Select Experience

Replace the basic multi-select UI with a searchable selection sheet for large datasets.

---

## Challenges Encountered

### Polymorphic JSON Decoding

The most interesting challenge was supporting multiple field types while keeping the rendering layer generic.

A straightforward Codable model becomes difficult when each field type contains different properties and validation requirements.

To solve this:

1. The field type is decoded first.
2. A discriminator enum determines the rendering strategy.
3. Unknown types safely fall back to `.unknown`.
4. Views remain decoupled from JSON implementation details.

This approach keeps the architecture scalable and makes introducing new field types straightforward.

---

## Running the Project

### Requirements

* Xcode 16+
* Swift 5.10
* iOS 16+

### Steps

1. Clone the repository
2. Open the Xcode project
3. Build and run
4. The form loads automatically from the bundled `form.json`

No network access is required.

---

## Unit Tests

The project includes tests for:

* TEXT decoding
* DROPDOWN decoding
* Unknown field decoding
* Theme parsing
* Required field validation
* Character limit enforcement
* Validation engine behavior

Run:

```text
⌘ + U
```

to execute the test suite.

---

## Submission Flow

1. User fills dynamic fields
2. User taps Save
3. Validation executes
4. Errors are shown inline if needed
5. Successful submissions generate a payload
6. Payload is printed to the console
7. Success alert is displayed

Example payload:

```json
{
  "campaign_name": "Summer Sale",
  "ad_networks": [
    "net_meta"
  ]
}
```

---

## Conclusion

This implementation demonstrates a scalable, production-oriented approach to building a server-driven UI system using SwiftUI, MVVM, and polymorphic Codable decoding. The architecture is intentionally designed to be resilient to backend changes, easy to extend with new field types, and simple to maintain over time.
