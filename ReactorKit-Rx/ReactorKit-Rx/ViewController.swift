//
//  ViewController.swift
//  ReactorKit-Rx
//
//  Created by 박상우 on 2022/02/12.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class ViewController: UIViewController, StoryboardView {

    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var loadButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.parentVC = self
    }
    
    func bind(reactor: DefaultReactor) {
        loadButton.rx.tap
            .map { Reactor.Action.imageLoadButtonTap(index: Int.random(in: 0...2 )) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.image ?? "" }
            .distinctUntilChanged()
            .subscribe(onNext: { self.imageView.loadImage(urlString: $0) })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }


}

