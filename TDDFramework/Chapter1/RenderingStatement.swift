//
//  Plays.swift
//  TDDFramework
//
//  Created by Andres Kwan on 19/09/21.
//

import Foundation

/*
 Requested changes
 1 - statement printed in HTML
 2 - add more play types
 */

func statement(invoice: Invoice, plays: [Play]) -> String {
    return renderPlainText(StatementData(invoice, plays))
}

func renderPlainText(_ statement: StatementData) -> String {
    var result = "Statement for \(statement.customer)\n";
    
    for aPerformance in statement.performances {
        guard let name = aPerformance.play?.name else { break }
        guard let amount = aPerformance.amount else { break }
        result += "  \(name): \(usd(amount)) (\(aPerformance.audience) seats)\n"
    }
    
    result += "Amount owed is \(usd(statement.totalAmount))\n";
    result += "You earned \(Int(statement.totalVolumeCredits)) credits\n";
    return result;
}

func renderHTML(_ statement: StatementData) { }


