//
//  MockingService.swift
//  poc-maxence-mottard
//
//  Created by Maxence on 09/10/2020.
//

import Foundation
import RxSwift

final class MockingService {
    private let isMocked = BehaviorSubject<Bool>.init(value: false)
    
    func toggleIsMocked() {
        isMocked.onNext(!getIsMocked())
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
