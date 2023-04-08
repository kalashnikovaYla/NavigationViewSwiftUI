//
//  ContentView.swift
//  NavigationViewSwiftUI
//
//  Created by sss on 08.04.2023.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var presentation
    @EnvironmentObject var userBuy: UserBuy
    
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Buy \(text) \(userBuy.caps)")
            
                
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentation()
                        } label: {
                            Text("Back")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                userBuy.caps += 1
                            } label: {
                                Text("+")
                            }
                            
                            Button {
                                guard userBuy.caps > 0 else {return}
                                userBuy.caps -= 1
                            } label: {
                                Text("-")
                            }
                        }
                    }
                    
                })
            .navigationBarBackButtonHidden()
        }
        
        .onAppear() {
            userBuy.caps = 0
        }
    }
        
}

class UserBuy: ObservableObject {
    @Published var caps = 0
}


struct ContentView: View {
    
    @ObservedObject var userBuy = UserBuy()
    @State var isShow = false
    
    let coffee = "Coffee"
    let tea = "Tea"
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 30) {
                Text("What would you like to order?")
                Text("You choose \(userBuy.caps) caps")
                
               
                NavigationLink(isActive: $isShow) {
                    DetailView(text: tea)
                } label: {
                    EmptyView()
                }
                
                Button {
                    isShow = true
                } label: {
                    Text("Go")
                }

            }
            
            .navigationBarTitle("Menu", displayMode: .large)
        }
        .environmentObject(userBuy)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
