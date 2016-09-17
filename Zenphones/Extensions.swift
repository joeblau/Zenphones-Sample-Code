//
//  Extensions.swift
//  Zenphones
//
//  Created by Joseph Blau on 6/13/15.
//  Copyright (c) 2015 Joe Blau. All rights reserved.
//

import Foundation
import AudioKit

func akp(_ num: Float) -> AKConstant {
    return AKConstant(float: num)
}

func akpi(_ num: Int) -> AKConstant {
    return AKConstant(integer: num)
}

func akps(_ str: String) -> AKConstant {
    return AKConstant(string: str)
}

func akpfn(_ file: String) -> AKConstant {
    return AKConstant(filename: file)
}

extension Int {
    var ak: AKConstant {return AKConstant(integer: self)}
}

extension Float {
    var ak: AKConstant {return AKConstant(float: self)}
    var midiratio: Float {return pow(2, self * 0.083333333333)}
}

extension Double {
    var ak: AKConstant {return AKConstant(float: Float(self))}
    var midiratio: Double {return pow(2, self * 0.083333333333)}
}

extension AKMultipleInputMathOperation {
    convenience init(inputs: AKParameter...) {
        self.init()
        self.inputs = inputs
    }
}

// Arithmetic operators

func + (left: AKParameter, right: AKParameter) -> AKParameter {
    return left.plus(right)
}

func + (left: AKControl, right: AKControl) -> AKControl {
    return left.plus(right)
}

func + (left: AKConstant, right: AKConstant) -> AKConstant {
    return left.plus(right)
}

func - (left: AKParameter, right: AKParameter) -> AKParameter {
    return left.minus(right)
}

func - (left: AKControl, right: AKControl) -> AKControl {
    return left.minus(right)
}

func - (left: AKConstant, right: AKConstant) -> AKConstant {
    return left.minus(right)
}

func * (left: AKParameter, right: AKParameter) -> AKParameter {
    return left.scaled(by: right)
}

func * (left: AKControl, right: AKControl) -> AKControl {
    return left.scaled(by: right)
}

func * (left: AKConstant, right: AKConstant) -> AKConstant {
    return left.scaled(by: right)
}

func / (left: AKParameter, right: AKParameter) -> AKParameter {
    return left.divided(by: right)
}

func / (left: AKControl, right: AKControl) -> AKControl {
    return left.divided(by: right)
}

func / (left: AKConstant, right: AKConstant) -> AKConstant {
    return left.divided(by: right)
}
