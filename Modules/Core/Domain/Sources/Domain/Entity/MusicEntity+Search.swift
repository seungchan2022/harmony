import Foundation

// MARK: - MusicEntity.Search

extension MusicEntity {
  public enum Search {
    public enum Song { }
    public enum Artist { }
    public enum Album { }
    public enum PlayList { }
    public enum TopResult { }
    public enum Keyword { }
  }
}

extension MusicEntity.Search.Song {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String

    public init(query: String) {
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case query = "term"
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "songs"
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

extension MusicEntity.Search.Artist {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String

    public init(query: String) {
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case query = "term"
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "songs"
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

extension MusicEntity.Search.Album {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String

    public init(query: String) {
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case query = "term"
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "albums"
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

extension MusicEntity.Search.PlayList {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String

    public init(query: String) {
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case query = "term"
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

extension MusicEntity.Search.TopResult {

  public struct Request: Equatable, Codable, Sendable {
    public let query: String

    public init(query: String) {
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case query = "term"
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
      title: String? = .none,
      artistName: String? = .none,
      name: String? = .none,
      artwork: ArtworkItem,
      itemType: ItemType)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.name = name
      self.artwork = artwork
      self.itemType = itemType
    }

    // MARK: Public

    public let id: String
    public let title: String?
    public let artistName: String?
    public let name: String?
    public let artwork: ArtworkItem
    public let itemType: ItemType

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case name
      case artwork
      case itemType
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

  public enum ItemType: Equatable, Codable, Sendable {
    case album
    case song
    case artist
    case unknown
  }
}

extension MusicEntity.Search.Keyword {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String

    public init(query: String) {
      self.query = query
    }

    private enum CodingKeys: String, CodingKey {
      case query = "term"
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case itemList = "suggestions"
    }
  }

  public struct Item: Equatable, Codable, Sendable {
    public let id: String
    public let displayTerm: String /// 사용자에게 보여질 단어
    public let searchTerm: String /// 실제 검색에 사용될 단어

    public init(
      id: String,
      displayTerm: String,
      searchTerm: String)
    {
      self.id = id
      self.displayTerm = displayTerm
      self.searchTerm = searchTerm
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case displayTerm
      case searchTerm
    }
  }
}

// MARK: - MusicEntity.Search.Song.Composite

extension MusicEntity.Search.Song {
  public struct Composite: Equatable, Sendable {
    public let request: MusicEntity.Search.Song.Request
    public let response: MusicEntity.Search.Song.Response

    public init(
      request: MusicEntity.Search.Song.Request,
      response: MusicEntity.Search.Song.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

// MARK: - MusicEntity.Search.Artist.Composite

extension MusicEntity.Search.Artist {
  public struct Composite: Equatable, Sendable {
    public let request: MusicEntity.Search.Artist.Request
    public let response: MusicEntity.Search.Artist.Response

    public init(
      request: MusicEntity.Search.Artist.Request,
      response: MusicEntity.Search.Artist.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

// MARK: - MusicEntity.Search.Album.Composite

extension MusicEntity.Search.Album {
  public struct Composite: Equatable, Sendable {
    public let request: MusicEntity.Search.Album.Request
    public let response: MusicEntity.Search.Album.Response

    public init(
      request: MusicEntity.Search.Album.Request,
      response: MusicEntity.Search.Album.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

// MARK: - MusicEntity.Search.PlayList.Composite

extension MusicEntity.Search.PlayList {
  public struct Composite: Equatable, Sendable {
    public let request: MusicEntity.Search.PlayList.Request
    public let response: MusicEntity.Search.PlayList.Response

    public init(
      request: MusicEntity.Search.PlayList.Request,
      response: MusicEntity.Search.PlayList.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

// MARK: - MusicEntity.Search.TopResult.Composite

extension MusicEntity.Search.TopResult {
  public struct Composite: Equatable, Sendable {
    public let request: MusicEntity.Search.TopResult.Request
    public let response: MusicEntity.Search.TopResult.Response

    public init(request: MusicEntity.Search.TopResult.Request, response: MusicEntity.Search.TopResult.Response) {
      self.request = request
      self.response = response
    }
  }
}

// MARK: - MusicEntity.Search.Keyword.Composite

extension MusicEntity.Search.Keyword {
  public struct Composite: Equatable, Sendable {
    public let request: MusicEntity.Search.Keyword.Request
    public let response: MusicEntity.Search.Keyword.Response

    public init(request: MusicEntity.Search.Keyword.Request, response: MusicEntity.Search.Keyword.Response) {
      self.request = request
      self.response = response
    }
  }
}
