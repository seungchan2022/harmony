import Foundation

// MARK: - MusicEntity.AlbumDetail

extension MusicEntity {
  public enum AlbumDetail {
    public enum Track { }
  }
}

extension MusicEntity.AlbumDetail.Track {
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

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      genreItemList: [String],
      releaseDate: Date,
      artwork: ArtworkItem,
      itemList: [Item])
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.genreItemList = genreItemList
      self.releaseDate = releaseDate
      self.artwork = artwork
      self.itemList = itemList
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let genreItemList: [String]
    public let releaseDate: Date
    public let artwork: ArtworkItem
    public let itemList: [Item]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case genreItemList = "genreNames"
      case releaseDate
      case artwork
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      trackNumber: Int)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.trackNumber = trackNumber
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let trackNumber: Int

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case trackNumber
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
