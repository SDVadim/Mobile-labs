//
//  Untitled.swift
//  Apple_music_UI
//
//  Created by MacBook on 24.04.2026.
//

import UIKit

struct Song {
    let title: String
    
    let artist: String
    
    let image: UIImage?
}


class Data {
    static let songs: [Song] = [
        Song(title: "Blinding Lights", artist: "The Weeknd", image: UIImage(systemName: "music.note")),
        Song(title: "Shape of You", artist: "Ed Sheeran", image: UIImage(systemName: "music.note")),
        Song(title: "Starboy", artist: "The Weeknd", image: UIImage(systemName: "music.note")),
        Song(title: "Believer", artist: "Imagine Dragons", image: UIImage(systemName: "music.note")),
        Song(title: "Thunder", artist: "Imagine Dragons", image: UIImage(systemName: "music.note")),
        Song(title: "Bad Guy", artist: "Billie Eilish", image: UIImage(systemName: "music.note")),
        Song(title: "Lovely", artist: "Billie Eilish", image: UIImage(systemName: "music.note")),
        Song(title: "Perfect", artist: "Ed Sheeran", image: UIImage(systemName: "music.note")),
        Song(title: "Havana", artist: "Camila Cabello", image: UIImage(systemName: "music.note")),
        Song(title: "Senorita", artist: "Shawn Mendes", image: UIImage(systemName: "music.note")),
        Song(title: "Faded", artist: "Alan Walker", image: UIImage(systemName: "music.note")),
        Song(title: "Alone", artist: "Alan Walker", image: UIImage(systemName: "music.note")),
        Song(title: "Lose Yourself", artist: "Eminem", image: UIImage(systemName: "music.note")),
        Song(title: "Without Me", artist: "Eminem", image: UIImage(systemName: "music.note")),
        Song(title: "God's Plan", artist: "Drake", image: UIImage(systemName: "music.note")),
        Song(title: "In My Feelings", artist: "Drake", image: UIImage(systemName: "music.note")),
        Song(title: "One Dance", artist: "Drake", image: UIImage(systemName: "music.note")),
        Song(title: "Circles", artist: "Post Malone", image: UIImage(systemName: "music.note")),
        Song(title: "Sunflower", artist: "Post Malone", image: UIImage(systemName: "music.note")),
        Song(title: "Rockstar", artist: "Post Malone", image: UIImage(systemName: "music.note"))
    ]
    
    static func getSongs() -> [Song] {
        return songs
    }
}
