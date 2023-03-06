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
        case message(String)
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
    ]
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { [weak self] collectionView, indexPath, identifier in
        switch identifier {
        case .message(let message):
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.messageCellName, for: indexPath) as! SampleCollectionViewCell
            cell.message = message
            cell.maxWidth = collectionView.bounds.width - 32
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applyMessages()
    }

    private func applyMessages() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(messages.map { Item.message($0) })
        dataSource.apply(snapShot)
    }
}

