//
//  NumberSection.swift
//  RxDataSources
//
//  Created by Krunoslav Zaher on 1/7/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

import Foundation
import RxDataSources

// MARK: Data

struct NumberSection {
    var header: String

    var numbers: [IntItem]

    var updated: NSDate

    init(header: String, numbers: [Item], updated: NSDate) {
        self.header = header
        self.numbers = numbers
        self.updated = updated
    }
}


struct IntItem {
    let number: Int
    let date: NSDate
}

// MARK: Just extensions to say how to determine identity and how to determine is entity updated

extension NumberSection
    : AnimatableSectionModelType {
    typealias Item = IntItem
    typealias Identity = String

    var identity: String {
        return header
    }

    var items: [IntItem] {
        return numbers
    }

    init(original: NumberSection, items: [Item]) {
        self = original
        self.numbers = items
    }
}

extension NumberSection
    : CustomDebugStringConvertible {
    var debugDescription: String {
        return "NumberSection(header: \"\(self.header)\", numbers: \(numbers.debugDescription), updated: date)"
    }
}

extension IntItem
    : IdentifiableType
    , Equatable {
    typealias Identity = Int

    var identity: Int {
        return number
    }
}

// equatable, this is needed to detect changes
func == (lhs: IntItem, rhs: IntItem) -> Bool {
    return lhs.number == rhs.number && lhs.date.isEqualToDate(rhs.date)
}

// MARK: Some nice extensions
extension IntItem
    : CustomDebugStringConvertible {
    var debugDescription: String {
        return "IntItem(number: \(number), date: date)"
    }
}

extension IntItem
    : CustomStringConvertible {

    var description: String {
        return "\(number) @ \(Int(date.timeIntervalSince1970) % 1000)"
    }
}