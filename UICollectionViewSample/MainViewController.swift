//
//  ViewController.swift
//  UICollectionViewSample
//
//  Created by Tetsuro Nakamura on 2023/03/07.
//

import UIKit

class MainViewController: UIViewController {
    private struct Message: Hashable {
        let id: Int
        let text: String
        var isStar: Bool
    }

    private enum Section: CaseIterable {
        case messages
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

    private lazy var messages = self.generateItems()
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { [weak self] collectionView, indexPath, identifier in
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.messageCellName, for: indexPath) as! SampleCollectionViewCell
        if let message = self?.messages[identifier] {
            cell.message = "\(message.id): \(message.text)"
            cell.isStar = message.isStar
            cell.maxWidth = collectionView.bounds.width - 32
            cell.starTapped = { self?.toggleStar(id: message.id) }
        }
        return cell
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyMessages()
    }

    private func generateItems() -> [Message] {
        (0..<20).map { Message(id: $0, text: String(repeating: "サンプルテキスト ", count: Int.random(in: 1..<8)), isStar: false) }
    }

    private func applyMessages() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(messages.map { $0.id })
        dataSource.apply(snapShot)
    }

    private func toggleStar(id: Int) {
        guard 0..<messages.count ~= id else { return }
        messages[id].isStar = !messages[id].isStar

        var snapshot = dataSource.snapshot()
        snapshot.reconfigureItems([id])
        dataSource.apply(snapshot)
    }
}

