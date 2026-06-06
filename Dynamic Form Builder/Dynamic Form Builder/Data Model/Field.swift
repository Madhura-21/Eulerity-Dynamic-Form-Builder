//
//  Field.swift
//  EulerityTakeHome
//
//  A single form field decoded from JSON.
//  Uses a custom `init(from:)` to decode all known properties safely,
//  regardless of field type — unknown types produce a valid `.unknown` field
//  that is silently skipped during rendering.
//

import Foundation

struct Field: Identifiable, Equatable {

    // MARK: - Core Properties (all fields)

    let id: String
    let order: Int
    let type: FieldType
    let label: String
    let required: Bool
    let errorMessage: String?
    let supportingText: String?

    // MARK: - TEXT-specific

    let subtype: TextSubtype?
    let placeholder: String?
    let maxLength: Int?
    let regex: String?

    // MARK: - DROPDOWN-specific

    let options: [DropdownOption]
    let allowMultiple: Bool
    let defaultValues: [String]

    // MARK: - CHECKBOX-specific

    /// Maps label-substrings → URLs for rich-text links.
    let metadata: [String: String]?
    let clickableTextColorHex: String?
}

// MARK: - Codable

extension Field: Codable {
    enum CodingKeys: String, CodingKey {
        case id, order, type, label, required
        case errorMessage       = "error_message"
        case supportingText     = "supporting_text"
        case subtype, placeholder
        case maxLength          = "max_length"
        case regex
        case options
        case allowMultiple      = "allow_multiple"
        case defaultValues      = "default_values"
        case metadata
        case clickableTextColorHex = "clickable_text_color"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        id             = try c.decode(String.self,    forKey: .id)
        order          = try c.decodeIfPresent(Int.self, forKey: .order) ?? 0
        type           = try c.decode(FieldType.self, forKey: .type)
        label          = try c.decodeIfPresent(String.self, forKey: .label) ?? ""
        required       = try c.decodeIfPresent(Bool.self, forKey: .required) ?? false
        errorMessage   = try c.decodeIfPresent(String.self, forKey: .errorMessage)
        supportingText = try c.decodeIfPresent(String.self, forKey: .supportingText)
        subtype        = try c.decodeIfPresent(TextSubtype.self, forKey: .subtype)
        placeholder    = try c.decodeIfPresent(String.self, forKey: .placeholder)
        maxLength      = try c.decodeIfPresent(Int.self, forKey: .maxLength)
        regex          = try c.decodeIfPresent(String.self, forKey: .regex)
        options        = try c.decodeIfPresent([DropdownOption].self, forKey: .options) ?? []
        allowMultiple  = try c.decodeIfPresent(Bool.self, forKey: .allowMultiple) ?? false
        defaultValues  = try c.decodeIfPresent([String].self, forKey: .defaultValues) ?? []
        metadata       = try c.decodeIfPresent([String: String].self, forKey: .metadata)
        clickableTextColorHex = try c.decodeIfPresent(String.self, forKey: .clickableTextColorHex)
    }
}
