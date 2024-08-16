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
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

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

  public var essentialAlbum: (MusicEntity.Artist.EssentialAlbum.Request) -> AnyPublisher<
    MusicEntity.Artist.EssentialAlbum.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Artist.EssentialAlbum.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithFeaturedAlbums = try await artist.with([.featuredAlbums])

            let featuredAlbumList = artistWithFeaturedAlbums.featuredAlbums ?? []

            let itemList = featuredAlbumList
              .map {
                MusicEntity.Artist.EssentialAlbum.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  artwork: .init(url: $0.artwork?.url(width: 320, height: 320)))
              }

            let result = MusicEntity.Artist.EssentialAlbum.Response(title: featuredAlbumList.title ?? "", itemList: itemList)
            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var fullAlbum: (MusicEntity.Artist.FullAlbum.Request) -> AnyPublisher<
    MusicEntity.Artist.FullAlbum.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Artist.FullAlbum.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithFullAlbums = try await artist.with([.fullAlbums])

            let fullAlbumList = artistWithFullAlbums.fullAlbums ?? []

            let itemList = fullAlbumList
              .map {
                MusicEntity.Artist.FullAlbum.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 320, height: 320)))
              }

            let result = MusicEntity.Artist.FullAlbum.Response(title: fullAlbumList.title ?? "", itemList: itemList)
            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var musicVideo: (MusicEntity.Artist.MusicVideo.Request) -> AnyPublisher<
    MusicEntity.Artist.MusicVideo.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Artist.MusicVideo.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithMusicVideo = try await artist.with([.musicVideos])

            let musicVideoList = artistWithMusicVideo.musicVideos ?? []

            let itemList = musicVideoList
              .map {
                MusicEntity.Artist.MusicVideo.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 320, height: 320)))
              }

            let result = MusicEntity.Artist.MusicVideo.Response(itemList: itemList)
            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var playList: (MusicEntity.Artist.PlayList.Request) -> AnyPublisher<
    MusicEntity.Artist.PlayList.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Artist.PlayList.Response, CompositeErrorRepository> { promise in
        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithPlayList = try await artist.with([.playlists])

            let playList = artistWithPlayList.playlists ?? []

            let itemList = playList
              .map {
                MusicEntity.Artist.PlayList.Item(
                  id: $0.id.rawValue,
                  name: $0.name,
                  curatorName: $0.curatorName ?? "",
                  artwork: .init(url: $0.artwork?.url(width: 180, height: 180)))
              }

            let result = MusicEntity.Artist.PlayList.Response(itemList: itemList)

            return promise(.success(result))

          } catch {
            return promise(.failure(.other(error)))
          }
        }
      }
      .eraseToAnyPublisher()
    }
  }

  public var single: (MusicEntity.Artist.Single.Request) -> AnyPublisher<
    MusicEntity.Artist.Single.Response,
    CompositeErrorRepository
  > {
    { req in
      Future<MusicEntity.Artist.Single.Response, CompositeErrorRepository> { promise in

        Task {
          do {
            let request = MusicCatalogResourceRequest<Artist>(matching: \.id, equalTo: MusicItemID(rawValue: req.id))

            let response = try await request.response()

            guard let artist = response.items.first else { return }

            let artistWithSignle = try await artist.with([.singles])

            let singleItemList = artistWithSignle.singles ?? []

            let itemList = singleItemList
              .map {
                MusicEntity.Artist.Single.Item(
                  id: $0.id.rawValue,
                  title: $0.title,
                  releaseDate: $0.releaseDate ?? .now,
                  artwork: .init(url: $0.artwork?.url(width: 180, height: 180)))
              }

            let result = MusicEntity.Artist.Single.Response(itemList: itemList)

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
