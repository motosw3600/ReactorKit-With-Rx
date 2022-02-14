//
//  ViewController.swift
//  ReactorKit-Rx2
//
//  Created by 박상우 on 2022/02/14.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class ViewController: UIViewController, View {
    var disposeBag = DisposeBag()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "count"
        
        return label
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
    }
    
    private func configureLayout() {
        view.addSubview(countLabel)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        view.addSubview(minusButton)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50).isActive = true
        
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 50).isActive = true
    }
    
    func bind(reactor: DefaultReactor) {
        minusButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        plusButton.rx.tap
            .map { Reactor.Action.increase}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.count }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

