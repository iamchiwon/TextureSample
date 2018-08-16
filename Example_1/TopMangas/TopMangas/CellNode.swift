//
//  CellNode.swift
//  TopMangas
//
//  Created by iamchiwon on 2018. 8. 16..
//  Copyright © 2018년 iamchiwon. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class CellNode: ASCellNode {

    let imageNode = ASNetworkImageNode()
    let rankTitle = ASTextNode()
    let rankLabel = ASTextNode()
    let scoreTitle = ASTextNode()
    let scoreLabel = ASTextNode()
    let titleLabel = ASTextNode()
    let publishLabel = ASTextNode()

    init(_ data: Manga) {
        super.init()
        automaticallyManagesSubnodes = true

        imageNode.url = URL(string: data.imageUrl)!

        rankTitle.attributedText = NSAttributedString(string: "RANK",
                                                      attributes: [
                                                              .foregroundColor: UIColor.lightGray,
                                                              .font: UIFont.systemFont(ofSize: 10, weight: .bold)
                                                      ])

        scoreTitle.attributedText = NSAttributedString(string: "SCORE",
                                                       attributes: [
                                                               .foregroundColor: UIColor.lightGray,
                                                               .font: UIFont.systemFont(ofSize: 10, weight: .bold)
                                                       ])

        rankLabel.attributedText = NSAttributedString(string: "\(data.rank)",
                                                      attributes: [
                                                              .foregroundColor: UIColor.yellow,
                                                              .font: UIFont.systemFont(ofSize: 50, weight: .bold)
                                                      ])

        scoreLabel.attributedText = NSAttributedString(string: String(format: "%.2f", data.score),
                                                       attributes: [
                                                               .foregroundColor: UIColor.red,
                                                               .font: UIFont.systemFont(ofSize: 50, weight: .light)
                                                       ])

        titleLabel.attributedText = NSAttributedString(string: data.title,
                                                       attributes: [
                                                               .foregroundColor: UIColor.darkGray,
                                                               .font: UIFont.systemFont(ofSize: 20, weight: .medium)
                                                       ])

        let publishInfo = "\(data.publishingStart) ~ \(data.publishingEnd.isEmpty ? "In Serial" : data.publishingEnd)"

        publishLabel.attributedText = NSAttributedString(string: publishInfo,
                                                         attributes: [
                                                                 .foregroundColor: UIColor.lightGray,
                                                                 .font: UIFont.systemFont(ofSize: 10, weight: .light)
                                                         ])

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 150, height: 150)
        imageNode.contentMode = .scaleAspectFill
        imageNode.borderWidth = 1
        imageNode.borderColor = UIColor.lightGray.cgColor
        imageNode.cornerRadius = 8
        
        rankLabel.style.alignSelf = .end
        scoreLabel.style.alignSelf = .end

        let scoreStack = ASStackLayoutSpec.vertical()
        scoreStack.children = [rankTitle, rankLabel, scoreTitle, scoreLabel]
        scoreStack.style.flexGrow = 1.0

        let imageStack = ASStackLayoutSpec.horizontal()
        imageStack.spacing = 16
        imageStack.children = [imageNode, scoreStack]

        let infoStack = ASStackLayoutSpec.vertical()
        infoStack.spacing = 4
        infoStack.children = [titleLabel, publishLabel]

        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 10
        stack.children = [imageStack, infoStack]

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15),
                                 child: stack)
    }
}
