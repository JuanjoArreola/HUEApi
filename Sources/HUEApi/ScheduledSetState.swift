//
//  ScheduledSetState.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/29/19.
//

import Foundation
import AsyncRequest

struct ScheduledSetState: Replaceable, Schedulable {
    var state: SetState
    var identifier: String
    var request: URLSessionRequest<SetState>
    var command: () -> Void
    
    func canBeReplacedWith(_ replaceable: Replaceable) -> Bool {
        guard let new = replaceable as? ScheduledSetState else { return false }
        return identifier == new.identifier && state.canBeReplacedWith(new.state)
    }
    
    func replace() {
        request.complete(with: HUEAPIError.replaced, in: .main)
    }
    
    func start() {
        command()
    }
}
