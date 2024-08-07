import Architecture
import Domain

public protocol DashboardEnvironmentUsable {
  var toastViewModel: ToastViewActionType { get }
  var musicUseCase: MusicUseCase { get }
  var musicCityTopUseCase: MusicCityTopUseCase { get }
  var musicSearchUseCase: MusicSearchUseCase { get }
}
