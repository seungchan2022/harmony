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
  var getTopSongItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .topSong(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchTopSongItem)
      }
    }
  }

  var getEssentialAlbumItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .essentialAlbum(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchEssentialAlbumItem)
      }
    }
  }

  var getFullAlbumItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .fullAlbum(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchFullAlbumItem)
      }
    }
  }

  var getMusicVideoItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .musicVideo(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchMusicVideoItem)
      }
    }
  }

  var getPlayItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .playList(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchPlayItem)
      }
    }
  }

  var getSingleItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .single(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchSingleItem)
      }
    }
  }

  var getSimilarArtistItem: (MusicEntity.Search.TopResult.Item) -> Effect<ArtistReducer.Action> {
    { item in
      .publisher {
        useCase.artistUseCase
          .similarArtist(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(ArtistReducer.Action.fetchSimilarArtistItem)
      }
    }
  }
}

extension MusicEntity.Search.TopResult.Item {
  fileprivate func serialized() -> MusicEntity.Artist.TopSong.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.EssentialAlbum.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.FullAlbum.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.MusicVideo.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.PlayList.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.Single.Request {
    .init(id: id)
  }

  fileprivate func serialized() -> MusicEntity.Artist.SimilarArtist.Request {
    .init(id: id)
  }
}
