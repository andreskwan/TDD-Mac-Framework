//
//  PlaysCostReportTests.swift
//  TDDFrameworkTests
//
//  Created by Andres Kwan on 19/09/21.
//

import XCTest
@testable import TDDFramework

class PlaysCostReportTests: XCTestCase {

    
    func test_statement_prints_sameResutAsTheBook() {
        //given
        let plays = getPlays(printData: true)
        let invoices = getInvoices(printData: true)
        
        //when
        let sut = statement(invoice: invoices.invoices[0], plays: plays.plays)
        
        //then
        let expectedStatement = """
            Statement for BigCo
              Hamlet: US$ 650,00 (55 seats)
              As You Like It: US$ 450,00 (35 seats)
              Othello: US$ 500,00 (40 seats)
            Amount owed is US$ 1.600,00
            You earned 47 credits\n
            """
        print(sut)
        XCTAssertEqual(sut, expectedStatement)
    }

    //MARK: helper functions
    func getPlays(printData: Bool = false) -> Plays {
        let decoder = JSONDecoder()
        var decodedPlays: Plays!
        do {
            decodedPlays = try decoder.decode(Plays.self, from: playsData)
            if (printData) { printDecodedPlays(decodedPlays) }
        } catch (let error) { print(error) }
        return decodedPlays
    }

    fileprivate func printDecodedPlays(_ decodedData: Plays) {
        for play in decodedData.plays {
            print("----------------------------------------------")
            print(play.name)
            print("----------------------------------------------")
        }
    }
    
    func getInvoices(printData: Bool = false) -> Invoices {
        let decoder = JSONDecoder()
        var decodedInvoices: Invoices!
        do {
            decodedInvoices = try decoder.decode(Invoices.self, from: invoicesData)
            if (printData) { printDecodedInvoices(decodedInvoices) }
        } catch (let error) { print(error) }
        return decodedInvoices
    }

    fileprivate func printDecodedInvoices(_ decodedData: Invoices) {
        for invoice in decodedData.invoices {
            print("----------------------------------------------")
            print(invoice.customer)
            print("----------------------------------------------")
        }
    }
}
