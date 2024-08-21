import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ArtistSideEffect

struct ArtistSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension ArtistSideEffect {
  var getTopSongItem: (MusicEntity.Artist.TopSong.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .topSong(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchTopSongItem)
      }
    }
  }

  var getEssentialAlbumItem: (MusicEntity.Artist.EssentialAlbum.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .essentialAlbum(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchEssentialAlbumItem)
      }
    }
  }

  var getFullAlbumItem: (MusicEntity.Artist.FullAlbum.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .fullAlbum(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchFullAlbumItem)
      }
    }
  }

  var getMusicVideoItem: (MusicEntity.Artist.MusicVideo.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .musicVideo(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchMusicVideoItem)
      }
    }
  }

  var getPlayListItem: (MusicEntity.Artist.PlayList.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .playList(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchPlayListItem)
      }
    }
  }

  var getSingleItem: (MusicEntity.Artist.Single.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .single(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchSingleItem)
      }
    }
  }

  var getSimilarArtistItem: (MusicEntity.Artist.SimilarArtist.Request) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .similarArtist(item)
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchSimilarArtistItem)
      }
    }
  }

  var routeToTopSong: (MusicEntity.Artist.TopSong.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.topSong.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToEssentialAlbumDetail: (MusicEntity.Artist.EssentialAlbum.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.albumDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToFullAlbum: (MusicEntity.Artist.FullAlbum.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.fullAlbum.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToSingleAlbum: (MusicEntity.Artist.Single.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.singleAlbum.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToAlbumDetail: (MusicEntity.Artist.FullAlbum.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.albumDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToPlayListDetail: (MusicEntity.Artist.PlayList.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.playListDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToSingleAlbumDetail: (MusicEntity.Artist.Single.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.albumDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToSimilarArtist: (MusicEntity.Artist.SimilarArtist.Response) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.similarArtist.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToArtist: (MusicEntity.Artist.SimilarArtist.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.artist.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}
