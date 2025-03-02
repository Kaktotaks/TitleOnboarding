//
//  AppView.swift
//  TitleOnboarding
//
//  Created by Леонід Шевченко on 01.03.2025.
//

import SwiftUI
import ComposableArchitecture

//struct AppView: View {
//    let store: StoreOf<AppStore>
//    
//    var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            NavigationStack(path: viewStore.binding(get: \.path, send: AppStore.Action.navigateTo)) {
//                StylistsFocusView(
//                    store: self.store.scope(
//                        state: \.stylistsFocus,
//                        action: AppStore.Action.stylistsFocus
//                    )
//                )
//                .navigationDestination(for: AppStore.State.Route.self) { route in
//                    switch route {
//                    case .styleCollection:
//                        IfLetStore(
//                            self.store.scope(
//                                state: \.styleCollection,
//                                action: AppStore.Action.styleCollection
//                            )
//                        ) { store in
//                            StyleCollectionView(store: store)
//                        }
//                    case .colorsCollection:
//                        IfLetStore(
//                            self.store.scope(
//                                state: \.colorsCollection,
//                                action: AppStore.Action.colorsCollection
//                            )
//                        ) { store in
//                            ColorsCollectionView(store: store)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
