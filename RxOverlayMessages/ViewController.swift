//  ViewController.swift
//  RxOverlayMessages
//
//  Created by Fred Sevillano on 3/10/18.
//  Copyright © 2018 Fred Sevillano All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var firstButton: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstButton.rx.tap
            .observeOn(ConcurrentMainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.showOverlay()
            }).disposed(by: disposeBag)
    }
    
    func showOverlay() {
        let overlay = OverlayMessage()
        overlay.activate(firstClosure: {
            // Do something when the user clicks the close button on the Overlay
            // The Overlay will remove itself from the superview
        }, completion: {
            // Add the Overlay to the navController
            self.navigationController?.view.addSubview(overlay)
        })
    }
}
