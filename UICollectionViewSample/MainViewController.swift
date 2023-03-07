//
//  ViewController.swift
//  UICollectionViewSample
//
//  Created by Tetsuro Nakamura on 2023/03/07.
//

import UIKit

class MainViewController: UIViewController {
    private enum Section: CaseIterable {
        case messages
    }

    private enum Item: Hashable {
        case message(Int, String, Bool)
    }

    private static let messageCellName = "SampleCollectionViewCell"

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: Self.messageCellName, bundle: nil), forCellWithReuseIdentifier: Self.messageCellName)
            collectionView.dataSource = dataSource
        }
    }
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout! {
        didSet {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    private var messages = [
        "サンプルテキスト サンプルテキスト サンプルテキスト サンプルテキスト",
        "サンプルテキスト サンプルテキスト サンプルテキスト",
        "サンプルテキスト サンプルテキスト サンプルテキスト サンプルテキスト",
        "サンプルテキスト サンプルテキスト",
    ]
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] collectionView, indexPath, identifier in
        switch identifier {
        case .message(let number, let message, let isStar):
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.messageCellName, for: indexPath) as! SampleCollectionViewCell
            cell.message = "\(number): \(message)"
            cell.isStar = isStar
            cell.maxWidth = collectionView.bounds.width - 32
            return cell
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyMessages()
    }

    private func applyMessages() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(messages.enumerated().map { index, message in Item.message(index, message, false) })
        dataSource.apply(snapShot)
    }
}

