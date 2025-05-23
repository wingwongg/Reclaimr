//
//  GroupAppStorage.swift
//  Reclaimr
//
//  Created by ben on 15/5/25.
//

import Foundation
import SwiftUI

@propertyWrapper
struct GroupAppStorage<T>: DynamicProperty {
    @State private var value: T
    private let key: String
    private let userDefaults: UserDefaults

    var wrappedValue: T {
        get { value }
        nonmutating set {
            value = newValue
            userDefaults.set(newValue, forKey: key)
        }
    }

    var projectedValue: Binding<T> {
        Binding(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 }
        )
    }

    init(wrappedValue: T, _ key: String, suiteName: String) {
        self.key = key
        self.userDefaults = UserDefaults(suiteName: suiteName)!
        let storedValue = userDefaults.object(forKey: key) as? T ?? wrappedValue
        _value = State(initialValue: storedValue)
    }
}

