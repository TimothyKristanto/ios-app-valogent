//
//  Agent.swift
//  Valogent
//
//  Created by Timothy Kristanto on 21/05/22.
//

import Foundation

struct AgentData: Codable {
    var status: Int
    var data: [Agent]
}

struct Agent: Codable {
    var uuid, displayName, description, developerName: String
    var characterTags: [String]?
    var displayIcon, displayIconSmall: String
    var bustPortrait, fullPortrait, fullPortraitV2: String?
    var killfeedPortrait: String
    var background: String?
    var backgroundGradientColors: [String]?
    var assetPath: String
    var isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent: Bool
    var role: Role?
    var abilities: [Ability]
    var voiceLine: VoiceLine
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case description = "description"
        case developerName, characterTags, displayIcon, displayIconSmall, bustPortrait, fullPortrait, fullPortraitV2, killfeedPortrait, background, backgroundGradientColors, assetPath, isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent, role, abilities, voiceLine
    }
}

// MARK: - Ability
struct Ability: Codable {
    var slot: Slot
    var displayName, abilityDescription: String
    var displayIcon: String?

    enum CodingKeys: String, CodingKey {
        case slot, displayName
        case abilityDescription = "description"
        case displayIcon
    }
}

enum Slot: String, Codable {
    case ability1 = "Ability1"
    case ability2 = "Ability2"
    case grenade = "Grenade"
    case passive = "Passive"
    case ultimate = "Ultimate"
}

// MARK: - Role
struct Role: Codable {
    var uuid: String
    var displayName: DisplayName
    var roleDescription: String
    var displayIcon: String
    var assetPath: String

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case roleDescription = "description"
        case displayIcon, assetPath
    }
}

enum DisplayName: String, Codable {
    case controller = "Controller"
    case duelist = "Duelist"
    case initiator = "Initiator"
    case sentinel = "Sentinel"
}

// MARK: - VoiceLine
struct VoiceLine: Codable {
    var minDuration, maxDuration: Double
    var mediaList: [MediaList]
}

// MARK: - MediaList
struct MediaList: Codable {
    var id: Int
    var wwise: String
    var wave: String
}
