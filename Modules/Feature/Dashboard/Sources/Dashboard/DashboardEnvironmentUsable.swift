import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var musicUseCase: MusicUseCase { get }
  var musicCityTopDetailUseCase: MusicCityTopDetailUseCase { get }
  var musicSearchUseCase: MusicSearchUseCase { get }
}
