//
//  DetailViewController.swift
//  Music Test
//
//  Created by Диас Жанкелдиев on 04.07.2022.
//

import AVFoundation
import UIKit

class DetailViewController: UIViewController {
    
    var songIndex: Int = 0
    var musicPlayerService: MusicPlayerService
    var viewModel = DetailViewModel()
    
    init?(coder: NSCoder, position: Int, musicPlayerService: MusicPlayerService) {
        self.songIndex = position
        self.musicPlayerService = musicPlayerService
        self.musicPlayerService.playingSongIndex = position
        self.musicPlayerService.buildPlayerWithSong(at: position)
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        audioTimer()
        blurEffect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let player = musicPlayerService.player {
            player.stop()
        }
    }
    
    //MARK: - @IBOutlets
    @IBOutlet weak var volumeChange: UISlider!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK: - Functions
    func configure() {
        guard let actualSong = musicPlayerService.actualSong else { return }
        
        musicPlayerService.perform(action: .playOrPause)
        changeImageAndLabels(song: actualSong)
    }
    
    func changeImageAndLabels(song: SongModel) {
        guard let player = musicPlayerService.player else { return }
        
        nameLabel.text = song.trackName
        artistLabel.text = song.artistName
        musicImage.image = UIImage(named: song.imageName)
        
        let buttonIcon = player.isPlaying ? "pause" : "play"
        playButton.setBackgroundImage(UIImage(systemName: "\(buttonIcon)"), for: .normal)
    }
    
    func getProgress() -> Float {
        let progress = Float(musicPlayerService.player!.currentTime / musicPlayerService.player!.duration)
        return progress
    }
    
    func audioTimer() {
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(audioProgress), userInfo: nil, repeats: true)
    }
    
    @objc func audioProgress() {
        guard let player = musicPlayerService.player else { return }
        
        if player.duration > 0.0 {
            progressView.setProgress(getProgress(), animated: true)
        }
    }

    
    //MARK: - @IBActions
    @IBAction func valueChangedSlider(_ sender: UISlider) {
        musicPlayerService.player?.setVolume(volumeChange.value, fadeDuration: TimeInterval())
    }
    
    @IBAction func playAndPauseButton(_ sender: UIButton) {
        guard let player = musicPlayerService.player else { return }
        
        musicPlayerService.perform(action: .playOrPause)
        let buttonIcon = player.isPlaying ? "pause" : "play"
        playButton.setBackgroundImage(UIImage(systemName: "\(buttonIcon)"), for: .normal)
    }
    
    @IBAction func nextSongButton(_ sender: UIButton) {
        guard let playlist = viewModel.playlist else { return }
        
        musicPlayerService.perform(action: .nextMusic)
        changeImageAndLabels(song: playlist[musicPlayerService.playingSongIndex])
    }
    
    @IBAction func previousSongButton(_ sender: UIButton) {
        guard let playlist = viewModel.playlist else { return }
        
        musicPlayerService.perform(action: .previousMusic)
        changeImageAndLabels(song: playlist[musicPlayerService.playingSongIndex])
    }
    
    @IBAction func playBack(_ sender: UIButton) {
        musicPlayerService.perform(action: .restartMusic)
    }
}

extension DetailViewController {
    
    func blurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
    }
}
