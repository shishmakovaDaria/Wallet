//
//  ViewController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 21.05.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        let redView = UIView()
        redView.backgroundColor = .red
        
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.center.equalToSuperview()
        }
    }
}
