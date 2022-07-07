//
//  MusicAction.swift
//  Music Test
//
//  Created by Диас Жанкелдиев on 05.07.2022.
//

import AVFoundation
import UIKit

public enum Actions {
    case playOrPause
    case nextMusic
    case previousMusic
    case restartMusic
}

public class MusicPlayerService {
    var playlist: [SongModel]?
    
    var playingSongIndex: Int
    var player: AVAudioPlayer?
    var actualSong: SongModel? {
        get {
            return playlist?[playingSongIndex]
        }
    }
    
    init(initialSongIndex: Int) {
        self.playingSongIndex = initialSongIndex
        initialConfiguration()
        buildPlayerWithSong(at: initialSongIndex)
    }
    
    private func initialConfiguration() {
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Error initializing the player")
        }
    }
    
    func buildPlayerWithSong(at index: Int) {
        self.playingSongIndex = index
        guard let song = actualSong else { return }
        guard let songUrl = Bundle.main.url(forResource: song.trackName, withExtension: "mp3") else {
            print("Cannot find the file in specified path")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: songUrl)
            self.player = player
        } catch {
            print("Could not instantiate player by the given mp3 url")
        }
    }
    
    func perform(action: Actions) {
        switch action {
        case .playOrPause:
            playPause()
        case .nextMusic:
            nextMusic()
        case .previousMusic:
            previousMusic()
        case .restartMusic:
            restartMusic()
        }
    }
    
    private func playPause() {
        guard let player = player else { return }
        
        if player.isPlaying {
            player.pause()
            return
        }
        player.play()
    }
    
    private func nextMusic() {
        guard let playlist = playlist else { return }

        let finalIndex = playlist.count - 1
        let position = playingSongIndex == finalIndex ? 0 : playingSongIndex + 1
        buildPlayerWithSong(at: position)
        playPause()
    }
    
    private func previousMusic() {
        guard let playlist = playlist else { return }

        let finalIndex = playlist.count - 1
        let position = playingSongIndex == 0 ? finalIndex : playingSongIndex - 1
        buildPlayerWithSong(at: position)
        playPause()
    }
    
    private func restartMusic() {
        player?.currentTime = 0
    }
}
