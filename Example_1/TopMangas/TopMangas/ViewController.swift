//
//  ViewController.swift
//  TopMangas
//
//  Created by iamchiwon on 2018. 8. 16..
//  Copyright © 2018년 iamchiwon. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: ASViewController<ASDisplayNode> {

    let tableNode = ASTableNode()
    let services = [APIService.topManga(), APIService.topAnime()]
    let titles = ["Top Manga!", "Top Anime!"]
    var contentData: [Manga] = []
    var contentType = 0
    var page = 1

    init() {
        super.init(node: ASDisplayNode())
        title = "Top Manga!"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titles[contentType]

        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(toggleContentType))
        navigationItem.setRightBarButton(rightBarButton, animated: true)

        tableNode.frame = node.bounds
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.leadingScreensForBatching = 4
        node.addSubnode(tableNode)

        fatchData()
    }

    @objc func toggleContentType() {
        contentType = 1 - contentType
        title = titles[contentType]
        
        contentData = []
        tableNode.reloadData()
        
        page = 1
        fatchData()
    }

    func fatchData(completed: ((Bool) -> ())? = nil) {
        guard page > 0 else { return }

        services[contentType](page) { [weak self] mangas in

            DispatchQueue.main.async {
                self?.contentData.append(contentsOf: mangas)
                self?.tableNode.reloadData()
            }

            self?.page += 1

            let isEnd = mangas.isEmpty
            if isEnd { self?.page = -1 }

            completed?(!isEnd)
        }
    }

}

extension ViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return contentData.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = contentData[indexPath.row]
        return {
            CellNode(item)
        }
    }

    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fatchData() { finished in
            context.completeBatchFetching(finished)
        }
    }
}


