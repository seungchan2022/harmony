import Combine
import Domain
import MusicKit

// MARK: - ArtistUseCasePlatform

public struct ArtistUseCasePlatform {
  public init() { }
}

// MARK: ArtistUseCase

extension ArtistUseCasePlatform: ArtistUseCase {
  public var topSong: (MusicEntity.Artist.TopSong.Request) -> AnyPublisher<
    MusicEntity.Artist.TopSong.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Artist.TopSong.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithTopSong = try await artist.with([.topSongs])

            let topSongList = artistWithTopSong.topSongs ?? []

            let itemList = topSongList
              .map {
                MusicEntity.Artist.TopSong.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.Artist.TopSong.Response(title: topSongList.title ?? "", itemList: itemList)
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