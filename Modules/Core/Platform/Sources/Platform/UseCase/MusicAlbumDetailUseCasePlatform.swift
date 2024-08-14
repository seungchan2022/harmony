import Combine
import Domain
import MusicKit

// MARK: - MusicAlbumDetailUseCasePlatform

public struct MusicAlbumDetailUseCasePlatform {
  public init() { }
}

// MARK: MusicAlbumDetailUseCase

extension MusicAlbumDetailUseCasePlatform: MusicAlbumDetailUseCase {
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
                  trackNumber: $0.trackNumber,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.AlbumDetail.Track.Response(itemList: itemList)
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
