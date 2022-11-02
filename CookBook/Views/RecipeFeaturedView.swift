//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Azam Jawad on 2022-04-05.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Featured recipes")
                .bold().padding(.leading)
                .font(Font.custom("Avenir Heavy",size: 24))
                .padding(.top, 40)
                
            
            GeometryReader { geo in
                
                TabView (selection: $tabSelectionIndex) {
                    
                    // Loop through each recipe
                    ForEach (0..<7) { index in
                        
                        // Only show those that should be featured
                        if model.recipes[index].featured == true {
                            
                            
                            // Recipe card button
                            Button(action: {
                                
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                                
                            }, label: {
                                
                                ZStack {
                                    Rectangle().foregroundColor(.white)
                                    
                                    VStack(spacing:0) {
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(5)
                                            .font(Font.custom("Avenir",size: 15))
                                    }
                                }
                                
                                
                            })
                            .tag(index)
                            .sheet(isPresented: $isDetailViewShowing) {
                                // Show recipe detail view
                                RecipeDetailView(recipe: model.recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle()).frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                                .shadow(radius: 10)
                                .cornerRadius(15)
                            
                            
                            
                        }
                        
                    }
                    
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode:   .always))
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preparation time")
                    .font(Font.custom("Avenir Heavy",size: 16))
                Text(model.recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir",size: 15))
                
                Text("Highlights")
                    .font(Font.custom("Avenir Heavy",size: 16))
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
            }
            .padding(.leading)
            
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
        
       
    }
    
    func setFeaturedIndex() {
        
        // find index of first recipe that is featured
        var index = model.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView().environmentObject(RecipeModel())
    }
}
