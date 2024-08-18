import Foundation

// MARK: - Link.Dashboard

extension Link {
  public enum Dashboard { }
}

// MARK: - Link.Dashboard.Path

extension Link.Dashboard {
  public enum Path: String, Equatable {
    case home
    case mostPlayedSong
    case cityTop
    case cityTopDetail
    case dailyTop
    case dailyTopDetail
    case topPlayList
    case playListDetail
    case topAlbum
    case albumDetail
    case topMusicVideo
    case search
    case artist
  }
}
