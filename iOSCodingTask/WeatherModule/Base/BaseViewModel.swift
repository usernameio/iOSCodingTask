//
//  BaseViewModel.swift
//  iOSCodingTask
//
//  Created by Ivan Vasilev on 4/5/23.
//

import Foundation

class BaseViewModel {
    
    let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
}
