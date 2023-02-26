//
//  GameCVCell.swift
//  MemoGame
//
//  Created by macBook on 26.02.2023.
//

import UIKit

class GameCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGame: UIImageView!
    {
        didSet {
            imageGame.clipsToBounds = true
            imageGame.contentMode = .scaleAspectFill
        }
    }
    

    
}
