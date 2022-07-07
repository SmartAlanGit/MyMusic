//
//  MainViewController.swift
//  Music Test
//
//  Created by Диас Жанкелдиев on 04.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    let musicPlayerService = MusicPlayerService(initialSongIndex: 0)
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchSong()
    }
    
    private func secondVC(for indexPath: IndexPath) {
        let position = indexPath.row
        
        guard let playlist = self.viewModel.playlist else { return }
        guard let secondVC = storyboard?.instantiateViewController(identifier: "showPlay", creator: { coder in
           
            self.musicPlayerService.playlist = playlist
            
            let vc = DetailViewController(coder: coder,
                                        position: position,
                                        musicPlayerService: self.musicPlayerService)
            vc?.viewModel.playlist = self.viewModel.playlist
            return vc
            
        }) else { return }

        present(secondVC, animated: true)
    }
}

//MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playlist?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let playlist = viewModel.playlist else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MusicTableViewCell
        let song = playlist[indexPath.row]
        
        let model = SongModel(trackName: song.trackName, artistName: song.artistName, imageName: song.imageName)
        cell.configure(music: model)
        
        return cell
    }
}

//MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        secondVC(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70)
        
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 7),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -7)
        ])
        
        label.text = "Recently Added"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

//MARK: - CollectionView Data Source
extension MainViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playlist?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let playlist = viewModel.playlist else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MusicCollectionViewCell
        
        let song = playlist[indexPath.row]
        let model = SongModel(trackName: song.trackName, artistName: song.artistName, imageName: song.imageName)
        cell.configure(music: model)

        return cell
    }
}

//MARK: - CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collectionHeader", for: indexPath) as? CollectionHeader {
                headerView.headerTitleCollection.text = "Recently Played"
                return headerView
            }
        default: return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        secondVC(for: indexPath)
    }
}
