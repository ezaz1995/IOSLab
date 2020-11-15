//
//  ResultViewController.swift
//  IOS Quiz app
//
//  Created by Sha Nawaz Hathalia on 2020-11-15.
//

import UIKit

class ResultViewController: UIViewController {

    let resultView = ResultView()
    
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        resultView.button.addTarget(self, action: #selector(backButtonHandlder), for: .touchUpInside)

    }
    
    @objc private func backButtonHandlder() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Navigation


}
