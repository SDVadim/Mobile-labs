//
//  AlbumViewController.swift
//  Apple_music_UI
//
//  Created by MacBook on 26.04.2026.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    var song: Song
    
    let albumImageView = UIImageView()
    
    let tableView = UITableView()
    
    let albumTitle = UILabel()
    
    let descriptionLabel = UILabel()
    
    let albumSongs: [Song] = [
        Song(title: "Song 1", artist: "Artist 1", image: UIImage(systemName: "music.note")),
        Song(title: "Song 2", artist: "Artist 2", image: UIImage(systemName: "music.note")),
        Song(title: "Song 3", artist: "Artist 3", image: UIImage(systemName: "music.note"))
    ]
    
    init(song: Song) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -28),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        albumImageView.image = UIImage(systemName: "sun.max")
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumImageView)
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            albumImageView.heightAnchor.constraint(equalToConstant: 250),
            albumImageView.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        albumTitle.text = "Album title for song: \"" + song.title + "\""
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumTitle)
        NSLayoutConstraint.activate([
            albumTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            albumTitle.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 16),
            albumTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "albumSongCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        contentView.addSubview(tableView)
        let height = CGFloat(albumSongs.count * 70)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: height)
            
        ])
        
        
        descriptionLabel.text = "Текст в три строки\nс описанием\nальбома"
        descriptionLabel.numberOfLines = 3
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .darkGray
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumSongs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumSongCell", for: indexPath)
        
        var cellConf = cell.defaultContentConfiguration()
        cellConf.text = albumSongs[indexPath.row].title
        cellConf.image = albumSongs[indexPath.row].image
        cellConf.imageProperties.maximumSize = CGSize(width: 44, height: 44)
        cell.contentConfiguration = cellConf
        
        cell.layer.cornerRadius = 16

        return cell
    }
}
