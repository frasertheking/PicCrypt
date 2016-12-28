//
//  SplitViewController.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-10.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import UIKit
import ISHPullUp

class SplitViewController: ISHPullUpViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    private func commonInit() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = storyBoard.instantiateViewController(withIdentifier: "main") as! MainController
        let bottomVC = storyBoard.instantiateViewController(withIdentifier: "panel") as! PanelViewController
        contentViewController = contentVC
        bottomViewController = bottomVC
        bottomVC.pullUpController = self
        contentDelegate = contentVC
        sizingDelegate = bottomVC
        stateDelegate = bottomVC
    }
}
