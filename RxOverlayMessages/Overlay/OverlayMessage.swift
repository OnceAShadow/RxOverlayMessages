//  OverlayMessage.swift
//  RxOverlayMessages
//
//  Created by Fred Sevillano on 3/11/18.
//  Copyright © 2018 Fred Sevillano All rights reserved.

import UIKit
import RxCocoa
import RxSwift

class OverlayMessage: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    let disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    init() {
        super.init(frame: UIApplication.shared.keyWindow!.screen.bounds)
        loadNib()
    }
    
    private func loadNib() {
        UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func activate(firstClosure: @escaping () -> Void, completion: @escaping () -> Void) {
        
        closeButton.rx.tap
            .observeOn(ConcurrentMainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.removeFromSuperview()
                firstClosure()
            }).disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            completion()
        }
    }
}
