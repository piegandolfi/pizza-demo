//
//  ImageCollectionViewCell.swift
//  PizzaDemo
//
//  Created by Pietro Gandolfi on 02/01/2019.
//  Copyright © 2019 Pietro Gandolfi. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "imageCell"

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.contentMode = .scaleAspectFit
        backgroundColor = UIColor.orange.withAlphaComponent(0.7)
    }

}
