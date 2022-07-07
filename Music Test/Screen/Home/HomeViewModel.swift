//
//  ViewModel.swift
//  Music Test
//
//  Created by Диас Жанкелдиев on 05.07.2022.
//

import Foundation

class HomeViewModel {
    var playlist: [SongModel]?
    
    public func fetchSong() {
        playlist = [SongModel(trackName: "7 Elements",
                             artistName: "Alberto Ruiz",
                             imageName: "Alberto Ruiz - 7 Elements (Original Mix)"),
                   SongModel(trackName: "Титры",
                             artistName: "JONY",
                             imageName: "Jony - Титры"),
                   SongModel(trackName: "Родная Пой",
                             artistName: "Myagi",
                             imageName: "Родной пой"),
                   SongModel(trackName: "Юность",
                             artistName: "DaBro",
                             imageName: "Dabro Юность"),
                   SongModel(trackName: "Пачка сигарет",
                             artistName: "Виктор Цой",
                             imageName: "Цой Пачка"),
                   SongModel(trackName: "Первое Свидание",
                             artistName: "Алёна Швец",
                             imageName: "первое свидание"),
                   SongModel(trackName: "Utopia",
                             artistName: "MiyaGi feat. Andy Panda",
                             imageName: "MiyaGi feat. Andy Panda - Utopia"),
                   SongModel(trackName: "Антигерой",
                             artistName: "Elman",
                             imageName: "Elman - Антигерой")]
    }
}

