//
//  MediaViewController.swift
//  Apple_music_UI
//
//  Created by MacBook on 24.04.2026.
//

import UIKit

class MediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let contentView = UIView()
    
    let menuCells: [String] = ["Плейлисты", "Песни", "Альбомы", "Загруженное"]
    
    let tableMenu = UITableView()
    
    let recentAddedTitle = UILabel()
    
    let recentAdded: [Song] = {
        let songs = Data.getSongs()
        
        var recent: [Song] = []
        
        for (i, song) in songs.enumerated() {
            if i >= songs.count - 4 {
                recent.append(song)
            }
        }
        return recent
    } ()
    
    let recentAddedCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Медиа"
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
        
        
        contentView.addSubview(tableMenu)
        tableMenu.delegate = self
        tableMenu.dataSource = self
        tableMenu.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        tableMenu.translatesAutoresizingMaskIntoConstraints = false
        tableMenu.isScrollEnabled = false
        NSLayoutConstraint.activate([
            tableMenu.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableMenu.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableMenu.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableMenu.heightAnchor.constraint(equalToConstant: CGFloat(menuCells.count * 75))
        ])
        
        
        recentAddedTitle.text = "Недавно добавленные"
        recentAddedTitle.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(recentAddedTitle)
        recentAddedTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentAddedTitle.topAnchor.constraint(equalTo: tableMenu.bottomAnchor, constant: 40),
            recentAddedTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
        
        recentAddedCollection.delegate = self
        recentAddedCollection.dataSource = self
        contentView.addSubview(recentAddedCollection)
        recentAddedCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        NSLayoutConstraint.activate([
            recentAddedCollection.topAnchor.constraint(equalTo: recentAddedTitle.bottomAnchor, constant: 16),
            recentAddedCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recentAddedCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recentAddedCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = menuCells[indexPath.row]
        cellConfig.textProperties.font = .systemFont(ofSize: 14)
        
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let menu = menuCells[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(
            title: "Функционал недоступен",
            message: "Данный раздел будет доступен в следующей версии",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        
        present(alert, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentAdded.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        let song = recentAdded[indexPath.row]
        let imageView = UIImageView()
        imageView.image = song.image
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameView = UILabel()
        nameView.text = song.title
        nameView.font = .systemFont(ofSize: 14)
        nameView.textAlignment = .center
        nameView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let artistView = UILabel()
        artistView.text = song.artist
        artistView.font = .systemFont(ofSize: 14)
        artistView.textAlignment = .center
        artistView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(nameView)
        cell.contentView.addSubview(artistView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 4),
            nameView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -4),
            
            artistView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 2),
            artistView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 4),
            artistView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -4),
            artistView.bottomAnchor.constraint(lessThanOrEqualTo: cell.contentView.bottomAnchor, constant: -4)
            ])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 32) / 2
            return CGSize(width: width, height: width)
        }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let song = recentAdded[indexPath.row]
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let albumView = AlbumViewController(song: song)
        
        navigationController?.pushViewController(albumView, animated: true)
    }
    
}
