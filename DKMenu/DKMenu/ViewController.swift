//
//  ViewController.swift
//  DKMenu
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 南京麦伦思. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(DKMenu.shared, animated: true) { }
    }

}

