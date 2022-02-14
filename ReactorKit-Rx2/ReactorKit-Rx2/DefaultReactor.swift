//
//  DefaultReactor.swift
//  ReactorKit-Rx2
//
//  Created by 박상우 on 2022/02/14.
//

import Foundation
import ReactorKit

final class DefaultReactor: Reactor {
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutaion {
        case increaseCount
        case decreaseCount
    }
    
    struct State {
        var count: Int = 0
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutaion> {
        switch action {
        case .increase:
            return Observable.just(Mutaion.increaseCount)
        case .decrease:
            return Observable.just(Mutaion.decreaseCount)
        }
    }
    
    func reduce(state: State, mutation: Mutaion) -> State {
        var state = state
        
        switch mutation {
        case .increaseCount:
            state.count += 1
        case .decreaseCount:
            state.count -= 1
        }
        
        return state
    }
}
