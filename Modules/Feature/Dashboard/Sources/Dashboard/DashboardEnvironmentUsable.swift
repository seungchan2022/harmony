import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var musicUseCase: MusicUseCase { get }
  var musicCityTopDetailUseCase: MusicCityTopDetailUseCase { get }
  var musicDailyTopDetailUseCase: MusicDailyTopDetailUseCase { get }
  var musicTopPlayListDetailUseCase: MusicTopPlayListDetailUseCase { get }
  var musicAlbumDetailUseCase: MusicAlbumDetailUseCase { get }
  var musicSearchUseCase: MusicSearchUseCase { get }
}
