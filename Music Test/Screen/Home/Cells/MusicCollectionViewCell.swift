//
//  CollectionViewCell.swift
//  Music Test
//
//  Created by Диас Жанкелдиев on 04.07.2022.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionLabel: UILabel!

    public func configure(music: SongModel) {
        collectionImage.image = UIImage(named: music.imageName)
        collectionLabel.text = music.trackName
    }
}
