import Combine
import Domain
import MusicKit

// MARK: - AlbumDetailUseCasePlatform

public struct AlbumDetailUseCasePlatform {
  public init() { }
}

// MARK: AlbumDetailUseCase

extension AlbumDetailUseCasePlatform: AlbumDetailUseCase {
  public var track: (MusicEntity.AlbumDetail.Track.Request) -> AnyPublisher<
    MusicEntity.AlbumDetail.Track.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.AlbumDetail.Track.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let playList = response.items.first else { return }

            let detailedPlayList = try await playList.with([.tracks])
            let tracks = detailedPlayList.tracks ?? []

            let itemList = tracks
              .map {
                MusicEntity.AlbumDetail.Track.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  trackNumber: $0.trackNumber ?? .zero)
              }

            let result = MusicEntity.AlbumDetail.Track.Response(
              id: playList.id.rawValue,
              title: playList.title,
              artistName: playList.artistName,
              genreItemList: playList.genreNames,
              releaseDate: playList.releaseDate ?? .now,
              artwork: .init(url: playList.artwork?.url(width: 180, height: 180)),
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
