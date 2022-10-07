//
//  ContentView.swift
//  JournalSwiftUI
//
//  Created by Ahmad Ardal on 2022-10-04.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var journal = Journal()
    
    @State var showPopup = false

    var body: some View {
        
        NavigationView {
        ZStack {

            
            MainContentView(journal: journal, showPopup: $showPopup).blur(radius: showPopup ? 3 : 0).navigationTitle("Journal").toolbar {
                ToolbarItem(placement: .automatic, content: {
        
                    Text("+").font(.system(size: 32)).onTapGesture {
                        withAnimation {
                            showPopup = true
                        }
                        
                    }
                })
                
                
            }
            
            if showPopup {
                
                PopupView(journal: journal, showPopup: $showPopup)
            }
        
            
            }
            
        }
        
    }
}


struct PopupView: View {
    
    @ObservedObject var journal: Journal
    @Binding var showPopup: Bool
    
    @State var title = ""
    @State var description = ""
    

    var body: some View {
        
        VStack(spacing: 20) {
            
            
            Spacer()
            
            Text("Add entry").font(.title).bold()
            
            
            VStack(alignment: .leading) {
            
            Text("Ange titel")
                TextField("", text: $title).textFieldStyle(.roundedBorder).foregroundColor(.black)
            
            Text("Ange beskrivning")
                TextEditor(text: $description).cornerRadius(5).foregroundColor(.black)
                
            }.padding()
            
            
            Button(action: {
                
                if title == "" || description == "" {
                    return
                }
                
                journal.addEntry(entry: JournalEntry(title: title, description: description, date: Date()))
                
                showPopup = false
                
                
            }, label: {
                Text("Save").bold()
            }).padding().background(.white).foregroundColor(.brown).cornerRadius(7)
            
           
            
            Button(action: {
                showPopup = false
            }, label: {
                Text("Cancel")
            })
            
            Spacer()
            
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6, alignment: .center)
            .background(.brown)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .transition(.scale)
    }
}


struct MainContentView: View {
    
    @ObservedObject var journal: Journal
    
    @Binding var showPopup: Bool
    
    var body: some View {
        
        VStack {
            
            List() {
                
                ForEach(journal.getAllEntries()) {
                    entry in
                    NavigationLink(destination: JournalEntryView(), label: {
                        Text(entry.title)
                    })

                    
                }
                
            }
            
            
//            if !showPopup {
//                Button(action: {
//                    showPopup = true
//                }, label: {
//                    Text("Add Entry").bold()
//                }).padding().background(.brown).foregroundColor(.white).cornerRadius(7)
//            }
            

        }
        
    }
}

struct JournalEntryView: View {
    
    
    var body: some View {
        
        Text("Hej")
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView()
        //PopupView(journal: Journal(), showPopup: .constant(true))
    }
}


