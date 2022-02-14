//
//  DefaultReactor.swift
//  ReactorKit-Rx
//
//  Created by 박상우 on 2022/02/13.
//

import Foundation
import ReactorKit

final class DefaultReactor: Reactor {
    private let imageURLs: [String] = [
        "https://t1.daumcdn.net/cfile/tistory/99CBFB3C5AE2934205",
        "https://cdn.crowdpic.net/list-thumb/thumb_l_29706D89218AD898213F3AE785D9C595.jpg",
        "https://seoulforest.or.kr/wordpress/wp-content/uploads/2017/09/IMG_0404-1024x683.jpg"
    ]
    var initialState: State
    
    enum Action {
        case imageLoadButtonTap(index: Int)
        case finishImageLoad
    }
    
    enum Mutation {
        case setImage(image: String)
        case setLoading(Bool)
    }
    
    struct State {
        var image: String?
        var isLoading: Bool = false
    }
    
    init() {
        self.initialState = State(image: nil, isLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .imageLoadButtonTap(index):
            print(index)
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.setImage(image: imageURLs[index])).delay(.seconds(1), scheduler: MainScheduler.instance)
            ])
        case .finishImageLoad:
            return Observable.just(Mutation.setLoading(false))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setImage(image):
            state.image = image
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        
        return state
    }
}
