//
//  CustomImageView.swift
//  ReactorKit-Rx
//
//  Created by 박상우 on 2022/02/13.
//

import UIKit
import RxSwift

class CustomImageView: UIImageView {
    var url: String?
    var task: URLSessionDataTask?
    unowned var parentVC: ViewController!
    var disposeBag = DisposeBag()
    
    func loadImage(urlString: String) {
        self.url = urlString
        cancel()
        
        if let urlStringData = urlString.data(using: .utf8),
           let url = URL(dataRepresentation: urlStringData, relativeTo: nil) {
            
            task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    if urlString == self.url {
                        DispatchQueue.main.async { [weak self] in
                            self?.image = UIImage(data: data)
                            if let reactor = self?.parentVC.reactor {
                                Observable.just(DefaultReactor.Action.finishImageLoad)
                                    .bind(to: reactor.action)
                                    .disposed(by: self!.disposeBag)
                            }
                        }
                    }
                }
            })
            task?.resume()
        } else {
            print("error")
        }
            
    }
    
    func cancel() {
        print(#function)
        task?.cancel()
    }
}
