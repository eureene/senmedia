//
//  AdConfiguration.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import Foundation
struct AdConfiguration: Decodable {
    let _id: String
    let adType: String
    let popupDialog: String
    let popupDialogTitle: String
    let popupDialogBody: String
    let popupDialogUrl: String
    let inAppUpdate: String
    var adEveryXclick: Int
    var checkIsAdShowing: Bool
    let contentType: [String]

    enum CodingKeys: String, CodingKey {
        case _id, adType, popupDialog, popupDialogTitle, popupDialogBody, popupDialogUrl, inAppUpdate, adEveryXclick, checkIsAdShowing, contentType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decode(String.self, forKey: ._id)
        adType = try container.decode(String.self, forKey: .adType)
        popupDialog = try container.decode(String.self, forKey: .popupDialog)
        popupDialogTitle = try container.decode(String.self, forKey: .popupDialogTitle)
        popupDialogBody = try container.decode(String.self, forKey: .popupDialogBody)
        popupDialogUrl = try container.decode(String.self, forKey: .popupDialogUrl)
        inAppUpdate = try container.decode(String.self, forKey: .inAppUpdate)

        // Decode adEveryXclick as String and convert to Int
        let adEveryXclickString = try container.decode(String.self, forKey: .adEveryXclick)
        adEveryXclick = Int(adEveryXclickString) ?? 0

        // Decode checkIsAdShowing as String and convert to Bool
        let checkIsAdShowingString = try container.decode(String.self, forKey: .checkIsAdShowing)
        checkIsAdShowing = Bool(checkIsAdShowingString) ?? false

        contentType = try container.decode([String].self, forKey: .contentType)
    }
}
