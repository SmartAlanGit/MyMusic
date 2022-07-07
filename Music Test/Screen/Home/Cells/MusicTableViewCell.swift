//
//  TableViewCell.swift
//  Music Test
//
//  Created by Диас Жанкелдиев on 04.07.2022.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var tableImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    public func configure(music: SongModel) {
        tableImage.image = UIImage(named: music.imageName)
        nameLabel.text = music.trackName
        artistLabel.text = music.artistName
    }
}
