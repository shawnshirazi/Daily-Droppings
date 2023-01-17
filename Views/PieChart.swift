//
//  PieChart.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 3/8/22.
//

import SwiftUI
import SwiftUICharts
import CoreData

struct PieChart: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Poop.entity(), sortDescriptors: [NSSortDescriptor(key: "poopTime", ascending: true)]) private var allTasks: FetchedResults<Poop>
    
    var body: some View {
        
        CustomNavView {
            GeometryReader { geo in
                VStack {
                    BarChartView(data: ChartData(values: [("Type 1",poopType1()),
                                                          ("Type 2",poopType2()),
                                                          ("Type 3",poopType3()),
                                                          ("Type 4",poopType4()),
                                                          ("Type 5",poopType5()),
                                                          ("Type 6",poopType6()),
                                                          ("Type 7",poopType7())]),
                                 title: "Total Types", legend: "Poop Types", form: ChartForm.extraLarge)
                        .padding(.top)
                    
                    LineView(data: poopDurationfunc(), title: "Time on Toilet", legend: "") // legend is optional
                        .padding()
                        .frame(width: geo.size.width, height: geo.size.height / 4)
                    
                    
                }
            }
            .customNavigationTitle("Statistics")
            .CustomNavBarBackButtonHidden(true)
        }
    }
    
    func poopDurationfunc() -> [Double] {
        var duration: Double = 15
        var arr: [Double] = []
        
        for task in allTasks {
            duration = task.poopDuration
            
            arr.append(duration)
//            print(duration)
//            print(arr)
        }
//        print(arr)
        return arr
    }
    
    func poopType1() -> Int {
        var type1: Int = 0
        var totalType1: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 1" {
                //print("success")
                type1 = Int(task.poopTypeDouble)
                totalType1 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType1
    }
    
    func poopType2() -> Int {
        var type2: Int = 0
        var totalType2: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 2" {
                //print("success")
                type2 = Int(task.poopTypeDouble)
                totalType2 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType2
    }
    
    func poopType3() -> Int {
        var type3: Int = 0
        var totalType3: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 3" {
                //print("success")
                type3 = Int(task.poopTypeDouble)
                totalType3 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType3
    }
    
    func poopType4() -> Int {
        var type4: Int = 0
        var totalType4: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 4" {
                //print("success")
                type4 = Int(task.poopTypeDouble)
                totalType4 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType4
    }
    
    func poopType5() -> Int {
        var type5: Int = 0
        var totalType5: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 5" {
                //print("success")
                type5 = Int(task.poopTypeDouble)
                totalType5 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType5
    }
    
    func poopType6() -> Int {
        var type6: Int = 0
        var totalType6: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 6" {
                //print("success")
                type6 = Int(task.poopTypeDouble)
                totalType6 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType6
    }
    
    func poopType7() -> Int {
        var type7: Int = 0
        var totalType7: Int = 0
        
        for task in allTasks {
            if task.poopType == "Type 7" {
                //print("success")
                type7 = Int(task.poopTypeDouble)
                totalType7 += 1
                //print("total type 1 \(totalType1)")
            } else {
                //print("error")
            }
        }
        return totalType7
    }
}
