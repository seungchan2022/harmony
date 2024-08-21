import Combine
import Domain
import MusicKit

// MARK: - TopSongUseCasePlatform

public struct TopSongUseCasePlatform {
  public init() { }
}

// MARK: TopSongUseCase

extension TopSongUseCasePlatform: TopSongUseCase {
  public var song: (MusicEntity.TopSong.Request) -> AnyPublisher<MusicEntity.TopSong.Response, CompositeErrorRepository> {
    { req in
      Future<MusicEntity.TopSong.Response, CompositeErrorRepository> { promise in

        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithTopSong = try await artist.with([.topSongs])

            var topSongList = artistWithTopSong.topSongs ?? []

            var allTopSongList = Array(topSongList)

            while topSongList.hasNextBatch {
              if let nextBatch = try? await topSongList.nextBatch(limit: 10) {
                allTopSongList = allTopSongList + nextBatch
                topSongList = nextBatch
              } else {
                break
              }
            }

            let itemList = allTopSongList
              .map {
                MusicEntity.TopSong.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  albumTitle: $0.albumTitle ?? "",
                  artistName: $0.artistName,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.TopSong.Response(
              title: topSongList.title ?? "인기곡",
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
