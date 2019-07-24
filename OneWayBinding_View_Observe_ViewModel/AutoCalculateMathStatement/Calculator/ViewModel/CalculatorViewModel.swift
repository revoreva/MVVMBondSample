//
//  CalculatorViewModel.swift
//  MVVMBondSample
//
//  Created by Reva Yoga Pradana on 18/07/19.
//  Copyright © 2019 reva. All rights reserved.
//

import UIKit
import Bond

class CalculatorViewModel {
    var statement: Observable<String?> = Observable<String?>("")
    var result: Observable<String> = Observable<String>("")
    
    func setupBinding() {
        _ = statement.observeNext { [weak self] newText in
            
            guard let newText = newText else { return }
            
            self?.requestResult(calculatorStatement: newText) { [weak self] result in
                self?.result.value = result
            }
        }
    }
    
    private func requestResult(calculatorStatement: String, completion: ((String) -> Void)?) {
        CalculatorService.getResult(expression: calculatorStatement) { error, model in
            guard error == nil, model.isResultValid, let result = model.result else {
                completion?("")
                return
            }
            
            completion?(result)
        }
    }
}
