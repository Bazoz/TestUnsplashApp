//
//  Array+Extensions.swift
//  TestUnsplashApp
//
//  Created by Yarik Mykhalko on 11.03.2023.
//

import Foundation

extension Array where Element: Hashable {
   
    /// Remove duplicates from the array, preserving the items order
    func filterDuplicates() -> [Element] {
        var set = Set<Element>()
        var filteredArray = [Element]()
        for item in self where set.insert(item).inserted {
            filteredArray.append(item)
        }
        return filteredArray
    }
}
