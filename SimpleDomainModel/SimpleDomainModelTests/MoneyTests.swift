//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import ExtDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: Money.validCurrencies.USD)
  let twelveUSD = Money(amount: 12, currency: Money.validCurrencies.USD)
  let fiveGBP = Money(amount: 5, currency: Money.validCurrencies.GBP)
  let fifteenEUR = Money(amount: 15, currency: Money.validCurrencies.EUR)
  let fifteenCAN = Money(amount: 15, currency: Money.validCurrencies.CAN)
  
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: Money.validCurrencies.USD)
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == Money.validCurrencies.USD)
    
    let tenGBP = Money(amount: 10, currency: Money.validCurrencies.GBP)
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == Money.validCurrencies.GBP)
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert(Money.validCurrencies.GBP)
    XCTAssert(gbp.currency == Money.validCurrencies.GBP)
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert(Money.validCurrencies.EUR)
    XCTAssert(eur.currency == Money.validCurrencies.EUR)
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert(Money.validCurrencies.CAN)
    XCTAssert(can.currency == Money.validCurrencies.CAN)
    XCTAssert(can.amount == 15)
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert(Money.validCurrencies.USD)
    XCTAssert(usd.currency == Money.validCurrencies.USD)
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert(Money.validCurrencies.USD)
    XCTAssert(usd.currency == Money.validCurrencies.USD)
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert(Money.validCurrencies.USD)
    XCTAssert(usd.currency == Money.validCurrencies.USD)
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert(Money.validCurrencies.EUR)
    let usd = eur.convert(Money.validCurrencies.USD)
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert(Money.validCurrencies.GBP)
    let usd = gbp.convert(Money.validCurrencies.USD)
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert(Money.validCurrencies.CAN)
    let usd = can.convert(Money.validCurrencies.USD)
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == Money.validCurrencies.USD)
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == Money.validCurrencies.GBP)
  }
  func testmoneyString() {
    let amount = "USD10"
    XCTAssert(tenUSD.description == amount)
  }
}

