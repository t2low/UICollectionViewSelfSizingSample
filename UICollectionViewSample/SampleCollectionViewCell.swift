//
//  SampleCollectionViewCell.swift
//  UICollectionViewSample
//
//  Created by Tetsuro Nakamura on 2023/03/07.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }

    var message: String = "" {
        didSet {
            messageLabel.text = message
        }
    }
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth else { return }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
}
