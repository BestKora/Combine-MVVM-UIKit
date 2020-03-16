//
//  ContentView.swift
//  Combine.Weathee.SwiftUI
//
//  Created by Tatiana Kornilova on 06/03/2020.
//  Copyright © 2020 Tatiana Kornilova. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = TempViewModel ()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Weather App")
                .font(.largeTitle)
            
            TextField("City", text: self.$model.city)
                .autocapitalization(.words)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                )
            
            Text("температура: \(model.temp)")
            Spacer()
        }
        .font(.title)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
