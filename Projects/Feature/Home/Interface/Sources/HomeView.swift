//
//  HomeView.swift
//  FeatureHome
//
//  Created by Haeseok Lee on 7/24/24.
//

import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    
    public let store: StoreOf<HomeFeature>
    
    public init(store: StoreOf<HomeFeature>) {
        self.store = store
    }
    
    public var body: some View {
        MainView(store: store)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

private struct MainView: View {
    
    let store: StoreOf<HomeFeature>

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // 상단 설정 및 타이틀
                HStack {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding()

                // 타이틀
                Text("헬스장 1시간 운동")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                // 캐릭터 리스트
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(store.players) { player in
                            VStack {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                                Text(player.name)
                                    .font(.caption)
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                }
                .padding(.bottom, 10)
                .frame(height: 100)
                
                // 등수 및 미션 타이머
                VStack {
                    Text("10등")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("1등을 따라잡기까지 2칸 남았어요!")
                    Text("오후 미션 인증 마감까지 00:00 남았어요")
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 10)
                
                // 게임 보드
                VStack(spacing: 0) {
                    ForEach(0..<4) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<3) { column in
                                Rectangle()
                                    .fill(getColor(row: row, column: column))
                                    .frame(width: 100, height: 100)
                                    //.overlay(self.getLabel(row: row, column: column))
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }

    // 각 칸의 색상 설정
    func getColor(row: Int, column: Int) -> Color {
        if row == 0 && column == 0 || row == 0 && column == 2 || row == 3 && column == 2 {
            return Color.black
        } else if row == 1 && column == 1 {
            return Color.red
        } else {
            return Color.white
        }
    }

    // 각 칸의 텍스트 설정
//    func getLabel(row: Int, column: Int) -> some View {
//        if row == 0 && column == 0 {
//            return Text("START")
//                .foregroundColor(.white)
//                .bold()
//        } else if row == 1 && column == 1 {
//            return Text("장기말")
//                .foregroundColor(.white)
//                .bold()
//        } else if row == 3 && column == 2 {
//            return Text("GOAL")
//                .foregroundColor(.white)
//                .bold()
//        } else {
//            return EmptyView()
//        }
//    }
}

