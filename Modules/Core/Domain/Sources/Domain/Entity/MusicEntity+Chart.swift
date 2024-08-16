import Foundation
import MusicKit

// MARK: - MusicEntity.Chart

extension MusicEntity {
  public enum Chart {
    public enum MostPlayedSong { }
    public enum CityTop { }
    public enum DailyTop { }
    public enum TopPlayList { }
    public enum TopAlbum { }
    public enum TopMusicVideo { }
  }
}

extension MusicEntity.Chart.MostPlayedSong {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int = 20) {
      self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
      case limit
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case artwork
    }
  }

  public struct ArtworkItem: Equatable, Codable, Sendable {
    public let url: URL?

    public init(
      url: URL? = .none)
    {
      self.url = url
    }
  }

}

extension MusicEntity.Chart.CityTop {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int = 20) {
      self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
      case limit
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      name: String,
      curatorName: String? = .none,
      artwork: ArtworkItem)
    {
      self.id = id
      self.name = name
      self.curatorName = curatorName
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let name: String
    public let curatorName: String?
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case curatorName
      case artwork
    }
  }

  public struct ArtworkItem: Equatable, Codable, Sendable {
    public let url: URL?

    public init(
      url: URL? = .none)
    {
      self.url = url
    }
  }
}

extension MusicEntity.Chart.DailyTop {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int = 20) {
      self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
      case limit
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      name: String,
      curatorName: String,
      artwork: ArtworkItem)
    {
      self.id = id
      self.name = name
      self.curatorName = curatorName
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let name: String
    public let curatorName: String
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case curatorName
      case artwork
    }
  }

  public struct ArtworkItem: Equatable, Codable, Sendable {
    public let url: URL?

    public init(
      url: URL? = .none)
    {
      self.url = url
    }
  }
}

extension MusicEntity.Chart.TopPlayList {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int = 20) {
      self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
      case limit
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      name: String,
      curatorName: String,
      artwork: ArtworkItem)
    {
      self.id = id
      self.name = name
      self.curatorName = curatorName
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let name: String
    public let curatorName: String
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case curatorName
      case artwork
    }
  }

  public struct ArtworkItem: Equatable, Codable, Sendable {
    public let url: URL?

    public init(
      url: URL? = .none)
    {
      self.url = url
    }
  }
}

extension MusicEntity.Chart.TopAlbum {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int = 20) {
      self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
      case limit
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      releaseDate: Date?,
      genreItemList: [String],
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.releaseDate = releaseDate
      self.genreItemList = genreItemList
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let releaseDate: Date?
    public let genreItemList: [String]
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case releaseDate
      case genreItemList = "genreNames"
      case artwork
    }
  }

  public struct ArtworkItem: Equatable, Codable, Sendable {
    public let url: URL?

    public init(
      url: URL? = .none)
    {
      self.url = url
    }
  }
}

extension MusicEntity.Chart.TopMusicVideo {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int = 20) {
      self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
      case limit
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case artwork
    }
  }

  public struct ArtworkItem: Equatable, Codable, Sendable {
    public let url: URL?

    public init(
      url: URL? = .none)
    {
      self.url = url
    }
  }

}
