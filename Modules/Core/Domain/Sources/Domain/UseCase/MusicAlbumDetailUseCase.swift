import Combine

public protocol MusicAlbumDetailUseCase {
  var track: (MusicEntity.AlbumDetail.Track.Request) -> AnyPublisher<
    MusicEntity.AlbumDetail.Track.Response,
    CompositeErrorRepository
  > { get }
}
