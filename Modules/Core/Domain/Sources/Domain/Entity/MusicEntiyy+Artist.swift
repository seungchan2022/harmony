import Foundation

// MARK: - MusicEntity.Artist

extension MusicEntity {
  public enum Artist {
    public enum TopSong { }
    public enum EssentialAlbum { }
    public enum FullAlbum { }
    public enum MusicVideo { }
    public enum PlayList { }
    public enum Single { }
    public enum SimilarArtist { }
  }
}

extension MusicEntity.Artist.TopSong {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
    }

    private enum CodingKeys: String, CodingKey {
      case id
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let title: String?
    public let itemList: [Item]

    public init(
      title: String? = .none,
      itemList: [Item])
    {
      self.title = title
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case title
      case itemList = "songs"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      releaseDate: Date,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.releaseDate = releaseDate
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let releaseDate: Date
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case releaseDate
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

extension MusicEntity.Artist.EssentialAlbum {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
    }

    private enum CodingKeys: String, CodingKey {
      case id
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let title: String?
    public let itemList: [Item]

    public init(
      title: String? = .none,
      itemList: [Item])
    {
      self.title = title
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case title
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
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

extension MusicEntity.Artist.FullAlbum {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
    }

    private enum CodingKeys: String, CodingKey {
      case id
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let title: String?
    public let itemList: [Item]

    public init(
      title: String? = .none,
      itemList: [Item])
    {
      self.title = title
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case title
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      releaseDate: Date,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.releaseDate = releaseDate
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let releaseDate: Date
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case releaseDate
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

extension MusicEntity.Artist.MusicVideo {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
    }

    private enum CodingKeys: String, CodingKey {
      case id
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
      releaseDate: Date,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.releaseDate = releaseDate
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let releaseDate: Date
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case releaseDate
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

extension MusicEntity.Artist.PlayList {
  public struct Request: Equatable, Sendable, Codable {
    public let id: String

    public init(id: String) {
      self.id = id
    }

    private enum CodingKeys: String, CodingKey {
      case id
    }
  }

  public struct Response: Equatable, Sendable, Codable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Sendable, Codable {

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

extension MusicEntity.Artist.Single {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
    }

    private enum CodingKeys: String, CodingKey {
      case id
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let title: String?
    public let itemList: [Item]

    public init(
      title: String? = .none,
      itemList: [Item])
    {
      self.title = title
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case title
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      releaseDate: Date,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.releaseDate = releaseDate
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let releaseDate: Date
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case releaseDate
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

extension MusicEntity.Artist.SimilarArtist {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
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
    public let id: String
    public let name: String
    public let artwork: ArtworkItem

    public init(
      id: String,
      name: String,
      artwork: ArtworkItem)
    {
      self.id = id
      self.name = name
      self.artwork = artwork
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case name
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
