//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Terry on 1/25/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @EnvironmentObject var plotData :PlotClass
    
    @ObservedObject private var calculator = CalculatePlotData()
    @State var isChecked:Bool = false
    @State var tempInput = ""
    
    @State var selector = 0

    var body: some View {
        
        VStack{
      
            CorePlot(dataForPlot: $plotData.plotArray[selector].plotData, changingPlotParameters: $plotData.plotArray[selector].changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
   /*
            CorePlot(dataForPlot: $plotData.plotArray[1].plotData, changingPlotParameters: $plotData.plotArray[1].changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            */
            HStack{
                
                HStack(alignment: .center) {
                    Text("temp:")
                        .font(.callout)
                        .bold()
                    TextField("temp", text: $tempInput)
                        .padding()
                }.padding()
                
                Toggle(isOn: $isChecked) {
                            Text("Display Error")
                        }
                .padding()
                
                
            }
            
            
            HStack{
                Button("exp(-x)", action: {
                    
                    self.selector = 0
                    self.calculate()
                    
                    // This forces a SwiftUI update
                    self.plotData.objectWillChange.send()
                    
                    
                }
                
                
                )
                .padding()
                
            }
            
            HStack{
                Button("x", action: {
                    
                    // This forces SwiftUI to update
                    self.plotData.objectWillChange.send()
                    
                    self.selector = 1
                    
                    self.calculate2()
                    
                    
                    
                }
                
                
                )
                .padding()
                
            }
            
        }
        
    }
    
    
    
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate(){
        
        var temp = 0.0
        
        //pass the plotDataModel to the Calculator
        calculator.plotDataModel = self.plotData.plotArray[0]
        
        //Calculate the new plotting data and place in the plotDataModel
        calculator.ploteToTheMinusX()
        
        
    }
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate2(){
        
        var temp = 0.0
        
        //pass the plotDataModel to the Calculator
        calculator.plotDataModel = self.plotData.plotArray[1]
        
        //Calculate the new plotting data and place in the plotDataModel
        calculator.plotYEqualsX()
        
        
    }
    

   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
