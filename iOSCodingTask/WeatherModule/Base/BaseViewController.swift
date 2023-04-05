//
//  BaseViewController.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/4/23.
//

import UIKit

class BaseViewController<VModel: BaseViewModel>: UIViewController {
    
    let viewModel: VModel
    
    init(viewModel: VModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}
