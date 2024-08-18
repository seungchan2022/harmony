import Combine
import Domain
import MusicKit

// MARK: - PlayListDetailUseCasePlatform

public struct PlayListDetailUseCasePlatform {
  public init() { }
}

// MARK: PlayListDetailUseCase

extension PlayListDetailUseCasePlatform: PlayListDetailUseCase {
  public var track: (MusicEntity.PlayListDetail.Track.Request) -> AnyPublisher<
    MusicEntity.PlayListDetail.Track.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.PlayListDetail.Track.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let playlist = response.items.first else { return }

            let detailedPlaylist = try await playlist.with([.tracks])
            let tracks = detailedPlaylist.tracks ?? []

            let itemList = tracks
              .map {
                MusicEntity.PlayListDetail.Track.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.PlayListDetail.Track.Response(itemList: itemList)
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
