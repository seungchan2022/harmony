import Foundation
import MusicKit

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
    public let itemList: [Item]

    public init(itemList: [Item]) {
      self.itemList = itemList
    }
  }

  public struct Item: Equatable, Codable, Sendable {

    // MARK: Lifecycle

    public init(
      id: String,
      title: String,
      artistName: String,
      trackNumber: Int? = .zero,
      artwork: ArtworkItem)
    {
      self.id = id
      self.title = title
      self.artistName = artistName
      self.trackNumber = trackNumber
      self.artwork = artwork
    }

    // MARK: Public

    public let id: String
    public let title: String
    public let artistName: String
    public let trackNumber: Int?
    public let artwork: ArtworkItem

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case artistName
      case trackNumber
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
