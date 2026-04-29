import UIKit

class MainViewController: UIViewController,
    UISearchBarDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    
    let searchView = UISearchBar()
    var filtered: [Song] = []
    let allSongs = Data.getSongs()
    let allSongsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Главная"
    
        
        searchView.placeholder = "Поиск песни"
        searchView.delegate = self
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        allSongsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        allSongsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteSongCell")
        allSongsTableView.dataSource = self
        allSongsTableView.delegate = self
        allSongsTableView.translatesAutoresizingMaskIntoConstraints = false
        allSongsTableView.separatorStyle = .singleLine
        
        view.addSubview(allSongsTableView)
        NSLayoutConstraint.activate([
            allSongsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            allSongsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allSongsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allSongsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSongs.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let song = allSongs[indexPath.row - 1]
            tableView.deselectRow(at: indexPath, animated: true)
            let albumView = AlbumViewController(song: song)
            navigationController?.pushViewController(albumView, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
            
            let songsToShow = searchView.text?.isEmpty == false ? filtered : allSongs
            cell.configure(with: songsToShow)
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteSongCell", for: indexPath)
        let song = allSongs[indexPath.row - 1]
        
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = song.title
        cellConfig.image = song.image
        cellConfig.imageProperties.maximumSize = CGSize(width: 40, height: 52)
        cellConfig.secondaryText = song.artist
        cell.contentConfiguration = cellConfig
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            filtered = []
            allSongsTableView.reloadData()
            return
        }
        
        filtered = allSongs.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        allSongsTableView.reloadData()
    }
}

extension MainViewController: CustomTableViewCellDelegate {
    func didSelectSong(_ song: Song) {
        let albumView = AlbumViewController(song: song)
        navigationController?.pushViewController(albumView, animated: true)
    }
}
protocol CustomTableViewCellDelegate: AnyObject {
    func didSelectSong(_ song: Song)
}


class CustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CustomTableViewCellDelegate?
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Популярные запросы"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        view.
    }()
    
    var filt: [Song] = []
    
    let popularCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(popularLabel)
        contentView.addSubview(popularCollection)
        
        popularCollection.delegate = self
        popularCollection.dataSource = self
        
        popularCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            popularLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            popularLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            popularCollection.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 12),
            popularCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            popularCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            popularCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            popularCollection.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with songs: [Song]) {
        filt = songs
        popularCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(filt.count, 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let song = filt[indexPath.row]
        
        let imageView = UIImageView()
        imageView.image = song.image
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameView = UILabel()
        nameView.text = song.title
        nameView.font = .systemFont(ofSize: 14)
        nameView.textAlignment = .center
        nameView.numberOfLines = 2
        nameView.translatesAutoresizingMaskIntoConstraints = false
        
        let artistView = UILabel()
        artistView.text = song.artist
        artistView.font = .systemFont(ofSize: 12)
        artistView.textAlignment = .center
        artistView.textColor = .gray
        artistView.numberOfLines = 1
        artistView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(nameView)
        cell.contentView.addSubview(artistView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 4),
            nameView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -4),
            
            artistView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 4),
            artistView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 4),
            artistView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -4),
            artistView.bottomAnchor.constraint(lessThanOrEqualTo: cell.contentView.bottomAnchor)
        ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let song = filt[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)

        delegate?.didSelectSong(song)
    }
}
