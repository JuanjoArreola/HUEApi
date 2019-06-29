//
//  Clamped.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/29/19.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
