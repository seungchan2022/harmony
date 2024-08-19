import Foundation
import MusicKit

// MARK: - MusicEntity.PlayListDetail

extension MusicEntity {
  public enum PlayListDetail {
    public enum Track { }
  }
}

extension MusicEntity.PlayListDetail.Track {
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
    public let name: String
    public let curatorName: String
    public let artwork: ArtworkItem
    public let itemList: [Item]

    public init(
      name: String,
      curatorName: String,
      artwork: ArtworkItem,
      itemList: [Item])
    {
      self.name = name
      self.curatorName = curatorName
      self.artwork = artwork
      self.itemList = itemList
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
