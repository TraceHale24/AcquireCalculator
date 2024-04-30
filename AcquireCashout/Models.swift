//
//  Models.swift
//  AcquireCashout
//
//  Created by Trace Miller Hale on 2/24/24.
//

import Foundation

struct Company {
    var name: String
    var tier: Int
}

struct CompanyTierMinAndMaxSize {
    var tier: Int
    var minSize: Int
    var maxSize: Int
}

struct MergerPayout {
    var totalTier: Int
    var primary: Int
    var secondary: Int
    var tertiary: Int?
}

struct StockCost {
    var cost: [Int]
}

struct PlayerGameData: Codable, Equatable {
    var name: String
    var username: String
    var towerStock: Int
    var sacksonStock: Int
    var festivalStock: Int
    var worldwideStock: Int
    var americanStock: Int
    var continentalStock: Int
    var imperialStock: Int
    var cash: Int
    var placement: Int?
}

struct GameStructure: Codable, Equatable {
    var name: String
    var gameName: String
    var owner: String
    var passcode: String
    var turnPlayerId: String
    var players: [PlayerGameData]
    var companySizes: [String: Int]
    var turnOrder: [Int: String]
    var stockRemaining: [String: Int]
    var gameOver: Bool
}

struct PlayerStructure: Codable, Equatable {
    var name: String
    var username: String
    var games: [String]
    var wins: Int
    var losses: Int
}


var allCompanyTiers = [
    CompanyTierMinAndMaxSize(tier: 0, minSize: 2, maxSize: 2),
    CompanyTierMinAndMaxSize(tier: 1, minSize: 3, maxSize: 3),
    CompanyTierMinAndMaxSize(tier: 2, minSize: 4, maxSize: 4),
    CompanyTierMinAndMaxSize(tier: 3, minSize: 5, maxSize: 5),
    CompanyTierMinAndMaxSize(tier: 4, minSize: 6, maxSize: 10),
    CompanyTierMinAndMaxSize(tier: 5, minSize: 11, maxSize: 20),
    CompanyTierMinAndMaxSize(tier: 6, minSize: 21, maxSize: 30),
    CompanyTierMinAndMaxSize(tier: 7, minSize: 31, maxSize: 40),
    CompanyTierMinAndMaxSize(tier: 8, minSize: 41, maxSize: 110)
]

var allTycoonMergerPayouts = [
    MergerPayout(totalTier: 0, primary: 2000, secondary: 1500, tertiary: 1000),
    MergerPayout(totalTier: 1, primary: 3000, secondary: 2200, tertiary: 1500),
    MergerPayout(totalTier: 2, primary: 4000, secondary: 3000, tertiary: 2000),
    MergerPayout(totalTier: 3, primary: 5000, secondary: 3700, tertiary: 2500),
    MergerPayout(totalTier: 4, primary: 6000, secondary: 4200, tertiary: 3000),
    MergerPayout(totalTier: 5, primary: 7000, secondary: 5000, tertiary: 3500),
    MergerPayout(totalTier: 6, primary: 8000, secondary: 5700, tertiary: 4000),
    MergerPayout(totalTier: 7, primary: 9000, secondary: 6200, tertiary: 4500),
    MergerPayout(totalTier: 8, primary: 10000, secondary: 7000, tertiary: 5000),
    MergerPayout(totalTier: 9, primary: 11000, secondary: 7700, tertiary: 5500),
    MergerPayout(totalTier: 10, primary: 12000, secondary: 8200, tertiary: 6000),
]

var allClassicMergerPayouts = [
    MergerPayout(totalTier: 0, primary: 2000, secondary: 1000),
    MergerPayout(totalTier: 1, primary: 3000, secondary: 1500),
    MergerPayout(totalTier: 2, primary: 4000, secondary: 2000),
    MergerPayout(totalTier: 3, primary: 5000, secondary: 2500),
    MergerPayout(totalTier: 4, primary: 6000, secondary: 3000),
    MergerPayout(totalTier: 5, primary: 7000, secondary: 3500),
    MergerPayout(totalTier: 6, primary: 8000, secondary: 4000),
    MergerPayout(totalTier: 7, primary: 9000, secondary: 4500),
    MergerPayout(totalTier: 8, primary: 10000, secondary: 5000),
    MergerPayout(totalTier: 9, primary: 11000, secondary: 5500),
    MergerPayout(totalTier: 10, primary: 12000, secondary: 6000),
]

var sackson = Company(name: "Sackson", tier: 0)
var tower = Company(name: "Tower", tier: 0)
var american = Company(name: "American", tier: 1)
var festival = Company(name: "Festival", tier: 1)
var worldwide = Company(name: "Worldwide", tier: 1)
var continental = Company(name: "Continental", tier: 2)
var imperial = Company(name: "Imperial", tier: 2)

var stockCost = StockCost(cost: [
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    1000,
    1100,
    1200
])


