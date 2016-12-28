//
//  ContentVC.swift
//  ISHPullUpSample
//
//  Created by Felix Lamouroux on 27.06.16.
//  Copyright © 2016 iosphere GmbH. All rights reserved.
//

import MapKit
import ISHPullUp

class ContentVC: UIViewController, ISHPullUpContentDelegate {
    @IBOutlet private weak var layoutAnnotationLabel: UILabel!

    // we use a root view to rely on the edge inset
    // (this cannot be set on the VC's view directly)
    @IBOutlet private weak var rootView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutAnnotationLabel.layer.cornerRadius = 2;
        
        // the mapView should use the rootView's layout margins
        // to correctly update the legal label and coordinate region
    }

    // MARK: ISHPullUpContentDelegate

    func pullUpViewController(_ vc: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController _: UIViewController) {
        // update edgeInsets
        rootView.layoutMargins = edgeInsets

        // call layoutIfNeeded right away to participate in animations
        // this method may be called from within animation blocks
        rootView.layoutIfNeeded()
    }
}
