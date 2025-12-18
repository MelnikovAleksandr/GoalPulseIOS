//
//  SwiftUIView.swift
//  Presentation
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Utils
import Observation

public struct CompetitonsPage: View {
    @Binding var navigationManager: NavigationManager
    @ObservedObject private var viewModel: CompetitionsViewModel
    
    public init(navigationManager: Binding<NavigationManager>, viewModel: Binding<CompetitionsViewModel>) {
        self._navigationManager = navigationManager
        self._viewModel = ObservedObject(wrappedValue: viewModel.wrappedValue)
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("CompetitionsPage")
                .font(.title)
                .padding()
            
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Загрузка данных...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            if let error = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    
                    Button("Повторить") {
                        Task {
                            await viewModel.loadCompetitions()
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
            
            if !viewModel.competitions.isEmpty {
                VStack(alignment: .leading) {
                    Text("Загружено лиг: \(viewModel.competitions.count)")
                        .font(.headline)
                    
                    List(viewModel.competitions) { competition in
                        VStack(alignment: .leading) {
                            Text(competition.name)
                                .font(.headline)
                            Text("ID: \(competition.id)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("ID: \(competition.lastUpdated)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: 300)
                }
                .padding()
            } else if !viewModel.isLoading && viewModel.errorMessage == nil {
                Text("Нет данных")
                    .foregroundColor(.gray)
            }
            
            Button("Загрузить данные") {
                viewModel.loadCompetitions()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button("Go to Standings") {
                navigationManager.toStandlings()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    CompetitonsPage(navigationManager: .constant(MockData.navManager), viewModel: .constant(MockData.competitionsViewModel))
}
