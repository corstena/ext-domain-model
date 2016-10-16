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
    public enum validCurrencies {
        case GBP
        case USD
        case CAN
        case EUR
    }
    
    public var amount : Int
    public var currency : validCurrencies
  
    public func convert(_ to: validCurrencies) -> Money {
        let usdEquivalent : Int = convertToUSD(originCurrency: self.currency, amount: self.amount)
        var newMoney : Money
        switch to {
            case validCurrencies.GBP:
                newMoney = Money(amount : usdEquivalent / 2, currency : validCurrencies.GBP)
            case validCurrencies.USD:
                newMoney = Money(amount : usdEquivalent, currency : validCurrencies.USD)
            case validCurrencies.CAN:
                newMoney = Money(amount : usdEquivalent * 5 / 4, currency : validCurrencies.CAN)
            case validCurrencies.EUR:
                newMoney = Money(amount : usdEquivalent * 3 / 2, currency : validCurrencies.EUR)
        }
        return newMoney
    }
    
    private func convertToUSD (originCurrency : validCurrencies, amount : Int) -> Int {
        switch originCurrency {
            case validCurrencies.USD:
                return amount
            case validCurrencies.GBP:
                return amount * 2
            case validCurrencies.EUR:
                return amount * 2 / 3
            case validCurrencies.CAN:
                return amount * 4 / 5
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
        switch self.type {
        case .Hourly(let rate):
            return Int(rate * Double(hours))
        case .Salary(let totalSalary):
            return totalSalary
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let rate):
            self.type = .Hourly(rate + amt)
        case .Salary(let totalSalary):
            self.type = .Salary(totalSalary + Int(amt))
        }
    }
}

//////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job }
        set(value) {
            if self.age >= 16 {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse }
        set(value) {
            if self.age >= 18 {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}

//////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        var ableToHaveChild : Bool = false
        for person in members {
            if person.age >= 21 {
                ableToHaveChild = true
            }
        }
        if ableToHaveChild {
            members.append(child)
        }
        return ableToHaveChild
    }
    
    open func householdIncome() -> Int {
        var totalIncome = 0
        for person in members {
            if person._job != nil {
                totalIncome += (person._job?.calculateIncome(2000))!
            }
        }
        return totalIncome
    }
}

//comment




