import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var musicUseCase: MusicUseCase { get }
  var cityTopDetailUseCase: CityTopDetailUseCase { get }
  var dailyTopDetailUseCase: DailyTopDetailUseCase { get }
  var playListDetailUseCase: PlayListDetailUseCase { get }
  var albumDetailUseCase: AlbumDetailUseCase { get }
  var searchUseCase: SearchUseCase { get }
  var artistUseCase: ArtistUseCase { get }
  var topSongUseCase: TopSongUseCase { get }
  var albumUseCase: AlbumUseCase { get }
}
