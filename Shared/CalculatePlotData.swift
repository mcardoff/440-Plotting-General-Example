//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    

    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red"{
            plotDataModel!.changingPlotParameters.lineColor = .red()
        }
        else{
            
            plotDataModel!.changingPlotParameters.lineColor = .blue()
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    @MainActor func appendDataToPlot(plotData: [plotDataType]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    func plotYEqualsX() async
    {
        
        theText = "y = x\n"
        
        await setThePlotParameters(color: "Red", xLabel: "x", yLabel: "y", title: "y = x")
        
        await resetCalculatedTextOnMainThread()
        
        
        var plotData :[plotDataType] =  []
        
        
        for i in 0 ..< 120 {
             
            //create x values here

            let x = -2.0 + Double(i) * 0.2

        //create y values here

        let y = x


            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        
        }
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
        
    }
    
    
    func ploteToTheMinusX() async
    {
        
        //set the Plot Parameters
        
        await setThePlotParameters(color: "Blue", xLabel: "x", yLabel: "y = exp(-x)", title: "y = exp(-x)")
        
        await resetCalculatedTextOnMainThread()
        
        theText = "y = exp(-x)\n"
        
        var plotData :[plotDataType] =  []
        for i in 0 ..< 60 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

        //create y values here

        let y = exp(-x)
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        }
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
        return
    }
    
    
        @MainActor func resetCalculatedTextOnMainThread() {
            //Print Header
            plotDataModel!.calculatedText = ""
    
        }
    
    
        @MainActor func updateCalculatedTextOnMainThread(theText: String) {
            //Print Header
            plotDataModel!.calculatedText += theText
        }
    
}



