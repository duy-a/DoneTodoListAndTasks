//
//  ContentView.swift
//  DoneTodoListAndTasks
//
//  Created by Duy Anh Ngac on 23/11/24.
//

import SwiftData
import SwiftUI

enum ListCategory: String, CaseIterable {
    case all
    case today
}

// TODO: move to separate file
struct PinTaskListLabel: View {
    var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "list.bullet.circle")
                Spacer()
                Text("100")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
            Text(text.capitalized)
                .lineLimit(1)
        }
    }
}

struct ContentView: View {
    @State private var selectedList: ListCategory? = nil

    private let pinnedListColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    LazyVGrid(columns: pinnedListColumns, spacing: 10) {
                        ForEach(ListCategory.allCases, id: \.self) { category in
                            Group {
                                // Note: for some reason SwiftUI doesn't support dynamic .buttonStyle
                                if selectedList == category {
                                    Button {
                                        selectedList = category
                                    } label: {
                                        PinTaskListLabel(text: category.rawValue)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.red)
                                } else {
                                    Button {
                                        selectedList = category
                                    } label: {
                                        PinTaskListLabel(text: category.rawValue)
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(.red)
                                }
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }

                Section {
                    Text("Another list")
                }
            }
        }
        detail: {
            if let selectedList {
                switch selectedList {
                case .all: TaskList(listCategory: .all)
                case .today: TaskList(listCategory: .today)
                }
            } else {
                Text("Please selected a list")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(StoreProvider.previewContainer)
}
