//
//  TabBar.swift
//  Frame Of Mind
//
//  Created by Dustin Nuzzo on 03.09.24.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack() {
                Overview()
            }
            .tabItem {
                Text("Home")
                Image(systemName: "house")
            }
            .tag(0)
            
            NavigationStack() {
                ChartView()
                    .navigationTitle("Charts")
            }
            .tabItem {
                Text("Charts")
                Image(systemName: "chart.bar.xaxis")
            }
        }
    }
}

#Preview {
    TabBar()
}
