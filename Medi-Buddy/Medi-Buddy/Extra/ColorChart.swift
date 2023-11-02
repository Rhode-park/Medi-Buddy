//
//  ColorChart.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/10/30.
//

enum ColorChart: CaseIterable {
    case midnight
    case cherryBlossom
    case avocado
}

struct Palette {
    let color = [ColorChart.midnight: [["MidnightOneHundred", "MidnightOneSeventyFive", "MidnightOneFifty"], ["MidnightTwoHundred", "MidnightTwoSeventyFive", "MidnightTwoFifty"], ["MidnightThreeHundred", "MidnightThreeSeventyFive", "MidnightThreeFifty"], ["MidnightFourHundred", "MidnightFourSeventyFive", "MidnightFourFifty"]],
                 ColorChart.cherryBlossom: [["MidnightOneHundred", "MidnightOneSeventyFive", "MidnightOneFifty"], ["MidnightTwoHundred", "MidnightTwoSeventyFive", "MidnightTwoFifty"], ["MidnightThreeHundred", "MidnightThreeSeventyFive", "MidnightThreeFifty"], ["MidnightFourHundred", "MidnightFourSeventyFive", "MidnightFourFifty"]],
                 ColorChart.avocado: [["MidnightOneHundred", "MidnightOneSeventyFive", "MidnightOneFifty"], ["MidnightTwoHundred", "MidnightTwoSeventyFive", "MidnightTwoFifty"], ["MidnightThreeHundred", "MidnightThreeSeventyFive", "MidnightThreeFifty"], ["MidnightFourHundred", "MidnightFourSeventyFive", "MidnightFourFifty"]]]
}
