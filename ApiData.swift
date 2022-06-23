//
//  ApiData.swift
//  FinanceApp
//
//  Created by Şevval Atmaca on 23.06.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass
    let success: Bool
    let message: String
    let code: Int
}

// MARK: - DataClass
struct DataClass: Codable {
    let timeZone: String
    let serverTime: Int
    let symbols: [Symbol]
    let currencies: [Currency]
    let currencyOperationBlocks: [CurrencyOperationBlock]
}

// MARK: - Currency
struct Currency: Codable {
    let id: Int
    let symbol: String
    let minWithdrawal, minDeposit: Double
    let precision: Int
    let address: Address
    let currencyType: CurrencyType
    let tag: Tag
    let color, name: String
    let isAddressRenewable, getAutoAddressDisabled, isPartialWithdrawalEnabled, isNew: Bool
}

// MARK: - Address
struct Address: Codable {
    let minLen, maxLen: Int?
}

enum CurrencyType: String, Codable {
    case crypto = "CRYPTO"
    case fiat = "FIAT"
}

// MARK: - Tag
struct Tag: Codable {
    let enable: Bool
    let name: String?
    let minLen, maxLen: Int?
}

// MARK: - CurrencyOperationBlock
struct CurrencyOperationBlock: Codable {
    let currencySymbol: String
    let withdrawalDisabled, depositDisabled: Bool
}

// MARK: - Symbol
struct Symbol: Codable {
    let id: Int
    let name, nameNormalized: String
    let status: Status
    let numerator: String
    let denominator: Denominator
    let numeratorScale, denominatorScale: Int
    let hasFraction: Bool
    let filters: [Filter]
    let orderMethods: [OrderMethod]
    let displayFormat: DisplayFormat
    let commissionFromNumerator: Bool
    let order: Int
    let priceRounding, isNew: Bool
    let marketPriceWarningThresholdPercentage: Double
    let maximumOrderAmount: JSONNull?
    let maximumLimitOrderPrice, minimumLimitOrderPrice: Double
}

enum Denominator: String, Codable {
    case btc = "BTC"
    case denominatorTRY = "TRY"
    case usdt = "USDT"
}

enum DisplayFormat: String, Codable {
    case empty = "#,###"
    case the00 = "#,##0.0"
    case the000 = "#,##0.00"
    case the0000 = "#,##0.000"
    case the00000 = "#,##0.0000"
    case the000000 = "#,##0.00000"
    case the0000000 = "#,##0.000000"
    case the00000000 = "#,##0.0000000"
    case the000000000 = "#,##0.00000000"
}

// MARK: - Filter
struct Filter: Codable {
    let filterType: FilterType
    let minPrice, maxPrice, tickSize, minExchangeValue: String
    let minAmount, maxAmount: JSONNull?
}

enum FilterType: String, Codable {
    case priceFilter = "PRICE_FILTER"
}

enum OrderMethod: String, Codable {
    case limit = "LIMIT"
    case market = "MARKET"
    case stopLimit = "STOP_LIMIT"
    case stopMarket = "STOP_MARKET"
}

enum Status: String, Codable {
    case trading = "TRADING"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
