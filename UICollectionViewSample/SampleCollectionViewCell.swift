//
//  SampleCollectionViewCell.swift
//  UICollectionViewSample
//
//  Created by Tetsuro Nakamura on 2023/03/07.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {

    private static let starImage = UIImage(systemName: "star")
    private static let starFillImage = UIImage(systemName: "star.fill")

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var starImageView: UIImageView!
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

    var isStar: Bool = true {
        didSet {
            starImageView.image = isStar ? Self.starFillImage : Self.starImage
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
