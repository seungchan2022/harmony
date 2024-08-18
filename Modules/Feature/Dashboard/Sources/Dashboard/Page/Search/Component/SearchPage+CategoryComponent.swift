import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.CategoryComponent

extension SearchPage {
  struct CategoryComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<SearchReducer>

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension SearchPage.CategoryComponent { }

// MARK: - SearchPage.CategoryComponent + View

extension SearchPage.CategoryComponent: View {
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 16) {
        ForEach(CategoryList.allCases, id: \.self) { item in
          Text(item.rawValue.capitalized)
            .fontWeight(.semibold)
            .foregroundStyle(
              colorScheme == .dark
                ? .white
                : store.category == item ? .white : .black)

            .padding(8)
            .background(
              store.category == item ? .pink : .clear)
            .clipShape(Capsule())
            .onTapGesture {
              store.category = item
            }
        }
      }
      .padding(12)
    }
    .frame(maxWidth: .infinity)
    .background(
      colorScheme == .dark
        ? .black
        : .white)
      .scrollIndicators(.hidden)
  }
}

// MARK: - SearchPage.CategoryComponent.ViewState

extension SearchPage.CategoryComponent {
  struct ViewState: Equatable { }
}
