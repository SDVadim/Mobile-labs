
import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let header = UIView()
    
    let nameLabel = UILabel()
    
    let avatarImageView = UIImageView()
    
    let favoriteSongTitle = UILabel()
    
    let favoriteSongs: [Song] = {
        let fav = Data.getSongs()
        var songs: [Song] = []
        for (i, song) in fav.enumerated() {
            if (i % 2 == 0) {
                songs.append(song)
            }
        }
        return songs
    } ()
    
    let tableViews = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Профиль"
    
        avatarImageView.image = UIImage(systemName: "person.crop.circle")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: header.topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        nameLabel.text = "Name \nSurname"
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
        
        favoriteSongTitle.text = "Любимые песни"
        favoriteSongTitle.translatesAutoresizingMaskIntoConstraints = false
        favoriteSongTitle.textAlignment = .left
        
        header.addSubview(favoriteSongTitle)
        NSLayoutConstraint.activate([
            favoriteSongTitle.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            favoriteSongTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            favoriteSongTitle.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -20)
        ])
        
        header.translatesAutoresizingMaskIntoConstraints = true
        let headerHeight: CGFloat = 200
        header.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight)
        
        tableViews.tableHeaderView = header
        tableViews.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteSongCell")
        tableViews.dataSource = self
        tableViews.delegate = self
        tableViews.isScrollEnabled = true
        tableViews.translatesAutoresizingMaskIntoConstraints = false
        tableViews.separatorStyle = .singleLine
        
        view.addSubview(tableViews)
        NSLayoutConstraint.activate([
            tableViews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViews.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViews.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViews.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteSongs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = favoriteSongs[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let albumView = AlbumViewController(song: song)
        
        navigationController?.pushViewController(albumView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteSongCell", for: indexPath)
        
        let song = favoriteSongs[indexPath.row]
        
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = song.title
        cellConfig.image = song.image
        cellConfig.imageProperties.maximumSize = CGSize(width: 44, height: 44)
        cellConfig.secondaryText = song.artist

        cell.contentConfiguration = cellConfig
        
        return cell
    }
}
