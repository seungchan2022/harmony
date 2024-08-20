import Combine
import Domain
import MusicKit

// MARK: - AlbumUseCasePlatform

public struct AlbumUseCasePlatform {
  public init() { }
}

// MARK: AlbumUseCase

extension AlbumUseCasePlatform: AlbumUseCase {
  public var album: (MusicEntity.Album.Request) -> AnyPublisher<MusicEntity.Album.Response, CompositeErrorRepository> {
    { req in
      Future<MusicEntity.Album.Response, CompositeErrorRepository> { promise in

        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithAlbum = try await artist.with([.fullAlbums])

            var albumList = artistWithAlbum.fullAlbums ?? []

            var allAlbumList = Array(albumList)

            while albumList.hasNextBatch {
              if let nextBatch = try? await albumList.nextBatch(limit: 10) {
                allAlbumList = allAlbumList + nextBatch
                albumList = nextBatch
              } else {
                break
              }
            }

            let itemList = allAlbumList
              .map {
                MusicEntity.Album.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.Album.Response(
              id: artist.id.rawValue,
              itemList: itemList)

            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

}
