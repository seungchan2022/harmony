import Foundation
import MusicKit

// MARK: - MusicEntity.Chart

extension MusicEntity {
  public enum Chart { }
}

extension MusicEntity.Chart {
  public struct Request: Equatable, Codable, Sendable {
    public let limit: Int

    public init(limit: Int) {
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
