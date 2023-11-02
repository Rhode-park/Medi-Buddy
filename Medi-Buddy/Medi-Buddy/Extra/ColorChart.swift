//
//  ColorChart.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/10/30.
//

enum ColorChart: String, CaseIterable {
    case midnight = "MIDNIGHT"
    case cherryBlossom = "CHERRYBLOSSOM"
    case avocado = "AVOCADO"
}

struct Palette {
    let color = [ColorChart.midnight: [["MidnightOneHundred", "MidnightOneSeventyFive", "MidnightOneFifty"], ["MidnightTwoHundred", "MidnightTwoSeventyFive", "MidnightTwoFifty"], ["MidnightThreeHundred", "MidnightThreeSeventyFive", "MidnightThreeFifty"], ["MidnightFourHundred", "MidnightFourSeventyFive", "MidnightFourFifty"]],
                 ColorChart.cherryBlossom: [["CherryBlossomOneHundred", "CherryBlossomOneSeventyFive", "CherryBlossomOneFifty"], ["CherryBlossomTwoHundred", "CherryBlossomTwoSeventyFive", "CherryBlossomTwoFifty"], ["CherryBlossomThreeHundred", "CherryBlossomThreeSeventyFive", "CherryBlossomThreeFifty"], ["CherryBlossomFourHundred", "CherryBlossomFourSeventyFive", "CherryBlossomFourFifty"]],
                 ColorChart.avocado: [["MidnightOneHundred", "MidnightOneSeventyFive", "MidnightOneFifty"], ["MidnightTwoHundred", "MidnightTwoSeventyFive", "MidnightTwoFifty"], ["MidnightThreeHundred", "MidnightThreeSeventyFive", "MidnightThreeFifty"], ["MidnightFourHundred", "MidnightFourSeventyFive", "MidnightFourFifty"]]]
}
