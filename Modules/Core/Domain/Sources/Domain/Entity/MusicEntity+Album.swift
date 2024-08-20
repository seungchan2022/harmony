import Foundation

// MARK: - MusicEntity.Album

extension MusicEntity {
  public enum Album { }
}

extension MusicEntity.Album {
  public struct Request: Equatable, Codable, Sendable {
    public let id: String

    public init(id: String) {
      self.id = id
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let id: String
    public let itemList: [Item]

    public init(
      id: String,
      itemList: [Item])
    {
      self.id = id
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case id
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
