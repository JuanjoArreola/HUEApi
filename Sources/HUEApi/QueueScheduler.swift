//
//  QueueScheduler.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/29/19.
//

import Foundation

public protocol Replaceable {
    func canBeReplacedWith(_ replaceable: Replaceable) -> Bool
    func replace()
}

public protocol Schedulable {
    func start()
}

public class QueueScheduler<T: Replaceable & Schedulable> {
    public var throughput: TimeInterval
    
    private var items: [T] = []
    private var lastStartedDate: Date?
    private var timer: Timer?
    
    public init(throughput: TimeInterval) {
        self.throughput = throughput
    }
    
    var shouldSchedule: Bool {
        if let last = lastStartedDate, last.timeIntervalSinceNow < throughput {
            return true
        }
        return false
    }
    
    func scheduleItem(_ item: T) {
        if let index = items.firstIndex(where: { $0.canBeReplacedWith(item) }) {
            items[index].replace()
            items[index] = item
        } else {
            items.append(item)
        }
        setUpTimer(at: lastStartedDate?.addingTimeInterval(throughput) ?? Date())
    }
    
    private func setUpTimer(at date: Date) {
        guard !(timer?.isValid ?? false) else { return }
        
        timer = Timer(fire: date, interval: throughput, repeats: true) { timer in
            if self.items.count > 0 {
                self.items.removeFirst().start()
                self.lastStartedDate = Date()
            } else {
                timer.invalidate()
            }
        }
        RunLoop.current.add(timer!, forMode: .default)
    }
}
