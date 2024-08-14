import Combine
import Domain
import MusicKit

// MARK: - MusicTopPlayListDetailUseCasePlatform

public struct MusicTopPlayListDetailUseCasePlatform {
  public init() { }
}

// MARK: MusicTopPlayListDetailUseCase

extension MusicTopPlayListDetailUseCasePlatform: MusicTopPlayListDetailUseCase {
  public var track: (MusicEntity.TopPlayListDetail.Track.Request) -> AnyPublisher<
    MusicEntity.TopPlayListDetail.Track.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.TopPlayListDetail.Track.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let playlist = response.items.first else { return }

            let detailedPlaylist = try await playlist.with([.tracks])
            let tracks = detailedPlaylist.tracks ?? []

            let itemList = tracks
              .map {
                MusicEntity.TopPlayListDetail.Track.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artistName: $0.artistName,
                  artwork: .init(url: $0.artwork?.url(width: 60, height: 60)))
              }

            let result = MusicEntity.TopPlayListDetail.Track.Response(itemList: itemList)
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
