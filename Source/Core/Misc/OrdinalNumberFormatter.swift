//
//  OrdinalNumberFormatter.swift
//  Eunomia
//
//  Created by Ian Grossberg on 11/26/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

// translated from http://stackoverflow.com/a/3316016
open class OrdinalNumberFormatter: NumberFormatter {

    open override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, range rangep: UnsafeMutablePointer<NSRange>?) throws {

        var integerNumber : Int = 0
        
        let scanner = Scanner(string: string)
        scanner.caseSensitive = false
        scanner.charactersToBeSkipped = CharacterSet.letters
        
        if scanner.scanInt(&integerNumber) == true
        {
            obj?.pointee = NSNumber(value: integerNumber)
        } else
        {
            throw UnableToCreateNumberFromStringError(string: string)
        }
    }
    
    override open func string(for obj: Any?) -> String? {
        if !(obj! as AnyObject).isKind(of: NSNumber.self)
        {
            return nil
        }
        var result : String?

        #if os(iOS)
        if let stringRepresentation = (obj! as AnyObject).stringValue
        {
            if stringRepresentation.count > 0
            {
                var ordinal : String?
                
                if stringRepresentation == "11" || stringRepresentation == "12" || stringRepresentation == "13"
                {
                    ordinal = "th"
                } else if let lastDigit = stringRepresentation.last
                {
                    ordinal = OrdinalNumberFormatter.ordinalSuffixForLastDigit(lastDigit)
                }
                
                if let ordinal = ordinal
                {
                    result = "\(stringRepresentation)\(ordinal)"
                }
            }
        }
        #elseif os(macOS)
        let stringRepresentation = (obj! as! NSNumber).stringValue
        if stringRepresentation.count > 0
        {
            var ordinal : String?
            
            if stringRepresentation == "11" || stringRepresentation == "12" || stringRepresentation == "13"
            {
                ordinal = "th"
            } else if let lastDigit = stringRepresentation.last
            {
                ordinal = OrdinalNumberFormatter.ordinalSuffixForLastDigit(lastDigit)
            }
            
            if let ordinal = ordinal
            {
                result = "\(stringRepresentation)\(ordinal)"
            }
        }
        #endif
        
        return result
    }
    
    open class func ordinalSuffixForLastDigit(_ digit : Character) -> String? {
        var result : String?
        
        if digit == "1"
        {
            result = "st"
        } else if digit == "2"
        {
            result = "nd"
        } else if digit == "3"
        {
            result = "rd"
        } else
        {
            result = "th"
        }

        return result
    }
}
