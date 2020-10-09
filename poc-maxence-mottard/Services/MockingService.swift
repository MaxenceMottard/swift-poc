//
//  MockingService.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 09/10/2020.
//

import Foundation
import RxSwift

final class MockingService {
    private var isMocked = BehaviorSubject<Bool>.init(value: false)
    
    func mockData() {
        isMocked.onNext(true)
    }
    
    func unmockData() {
        isMocked.onNext(false)
    }
    
    func toggleIsMocked() {
        if (getIsMocked()) {
            unmockData()
        } else {
            mockData()
        }
    }
    
    func getIsMockedSubject() -> BehaviorSubject<Bool> {
        return self.isMocked
    }
    
    func getIsMocked() -> Bool {
        do {
            return try isMocked.value()
        } catch {
            return false
        }
    }
}
