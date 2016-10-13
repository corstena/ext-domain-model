//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
  
    public func convert(_ to: String) -> Money {
        let usdEquivalent : Int = convertToUSD(originCurrency: self.currency, amount: self.amount)
        var newMoney : Money
        switch to {
            case "GBP":
                newMoney = Money(amount : usdEquivalent / 2, currency : "GBP")
            case "USD":
                newMoney = Money(amount : usdEquivalent, currency : "USD")
            case "CAN":
                newMoney = Money(amount : usdEquivalent * 5 / 4, currency : "CAN")
            case "EUR":
                newMoney = Money(amount : usdEquivalent * 3 / 2, currency : "EUR")
            default:
                newMoney = Money(amount : self.amount, currency: self.currency)
        }
        return newMoney
    }
    
    private func convertToUSD (originCurrency : String, amount : Int) -> Int {
        switch originCurrency {
            case "USD":
                return amount
            case "GBP":
                return amount * 2
            case "EUR":
                return amount * 2 / 3
            case "CAN":
                return amount * 4 / 5
            default:
            print("Please enter valid currency type")
            return amount
        }
    }

  
    public func add(_ to: Money) -> Money {
        if self.currency == to.currency {
            return Money(amount: self.amount + to.amount, currency : self.currency)
        } else {
            let convertedCurrency = self.convert(to.currency)
            return Money(amount: convertedCurrency.amount + to.amount, currency: to.currency)
            
        }
    }
    
    public func subtract(_ from: Money) -> Money {
        if self.currency == from.currency {
            return Money(amount: from.amount - self.amount, currency : self.currency)
        }
        let convertedCurrency = self.convert(from.currency)
        return Money(amount: from.amount - convertedCurrency.amount, currency: from.currency)
    }
}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        
    }
    
    open func raise(_ amt : Double) {
    }
}

////////////////////////////////////
//// Person
////
//open class Person {
//    open var firstName : String = ""
//    open var lastName : String = ""
//    open var age : Int = 0
//    
//    fileprivate var _job : Job? = nil
//    open var job : Job? {
//        get { }
//        set(value) {
//        }
//    }
//    
//    fileprivate var _spouse : Person? = nil
//    open var spouse : Person? {
//        get { }
//        set(value) {
//        }
//    }
//    
//    public init(firstName : String, lastName: String, age : Int) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.age = age
//    }
//    
//    open func toString() -> String {
//    }
//}
//
//////////////////////////////////////
//// Family
////
//open class Family {
//    fileprivate var members : [Person] = []
//    
//    public init(spouse1: Person, spouse2: Person) {
//    }
//    
//    open func haveChild(_ child: Person) -> Bool {
//    }
//    
//    open func householdIncome() -> Int {
//    }
//}





