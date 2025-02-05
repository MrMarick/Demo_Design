//
//  CollectionViewData.swift
//  Demo_Design
//
//  Created by Karma Strategies on 03/02/25.
//

import Foundation
struct ShortcutItem {
    let title: String
    let imageName: String
}

final class CollectionViewData{
    private init(){}
    static let shared = CollectionViewData()
    var shortcutData: [ShortcutItem] = [
        ShortcutItem(title: "Meditation", imageName: "meditation"),
        ShortcutItem(title: "Workout", imageName: "workout"),
        ShortcutItem(title: "Sleep", imageName: "sleep")
    ]
    var exploreData: [ShortcutItem] = [
        ShortcutItem(title: "Mantra", imageName: "mantra"),
        ShortcutItem(title: "Events", imageName: "events"),
        ShortcutItem(title: "Courses", imageName: "courses"),
        ShortcutItem(title: "Community", imageName: "community"),
        ShortcutItem(title: "Timer", imageName: "Timer"),
        ShortcutItem(title: "Affirmation", imageName: "affirmation"),
        ShortcutItem(title: "Music", imageName: "music"),
        ShortcutItem(title: "Journal", imageName: "journal")
    ]
    var closeData: [ShortcutItem] = [
        ShortcutItem(title: "Close", imageName: "close")
    ]
    var moreData: [ShortcutItem] = [
        ShortcutItem(title: "More", imageName: "more")
    ]
}
