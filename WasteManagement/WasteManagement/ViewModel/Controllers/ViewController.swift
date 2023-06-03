//
//  ViewController.swift
//  WasteManagement
//
//  Created by Rencheeraj Mohan on 02/06/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIManager.shared.getJsonResult() { result in
            switch result{
            case .success(let json):
                print(json)
                self.dataFromRequest(vc: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    func dataFromRequest(vc : Response){
        print(vc)
    }

}

