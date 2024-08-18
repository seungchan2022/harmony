import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.KeywordComponent

extension SearchPage {
  struct KeywordComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Search.Keyword.Item) -> Void

    @Bindable var store: StoreOf<SearchReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension SearchPage.KeywordComponent { }

// MARK: - SearchPage.KeywordComponent + View

extension SearchPage.KeywordComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading) {
        Spacer()
        HStack {
          Image(systemName: "magnifyingglass")
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)

          Text(viewState.item.displayTerm)
            .font(.body)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
            .overlay(alignment: .leading) {
              if viewState.item.displayTerm.lowercased().hasPrefix(store.query.lowercased()) {
                Text(store.query.lowercased())
                  .font(.body)
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)
              }
            }

          Spacer()
        }

        Spacer()

        Divider()
      }
    }
    .padding(.leading, 12)
    .padding(.vertical, 8)
  }

}

// MARK: - SearchPage.KeywordComponent.ViewState

extension SearchPage.KeywordComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Search.Keyword.Item
  }
}
