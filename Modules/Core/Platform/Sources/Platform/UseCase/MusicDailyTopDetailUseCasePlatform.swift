import Combine
import Domain
import MusicKit

// MARK: - MusicDailyTopDetailUseCasePlatform

public struct MusicDailyTopDetailUseCasePlatform {
  public init() { }
}

// MARK: MusicDailyTopDetailUseCase

extension MusicDailyTopDetailUseCasePlatform: MusicDailyTopDetailUseCase {
  public var track: (MusicEntity.DailyTopDetail.Track.Request) -> AnyPublisher<
    MusicEntity.DailyTopDetail.Track.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.DailyTopDetail.Track.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            var request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))
            request.limit = 100

            let response = try await request.response()

            guard let playlist = response.items.first else { return }

            let detailedPlaylist = try await playlist.with([.tracks])
            let tracks = detailedPlaylist.tracks ?? []

            let itemList = tracks
              .map {
                MusicEntity.DailyTopDetail.Track.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.DailyTopDetail.Track.Response(itemList: itemList)
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
