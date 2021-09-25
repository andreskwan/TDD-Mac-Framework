//
//  Plays.swift
//  TDDFramework
//
//  Created by Andres Kwan on 19/09/21.
//

import Foundation

class Cost {
    func statement(invoice: Invoice, plays: [Play]) -> String {
        return renderPlainText(StatementData(invoice, plays))
    }
    
    /* Nesting the extracted function
     - This is helpful as it means I don't have to pass data that's inside the scope of the containing function to the newly extracted function.
     - all the extracted nested functions turn statement into a class?
     */
    
    func renderPlainText(_ statement: StatementData) -> String {
        var result = "Statement for \(statement.customer)\n";
        
        for aPerformance in statement.performances {
            guard let name = aPerformance.play?.name else { break }
            result += "  \(name): \(usd(aPerformance.amount)) (\(aPerformance.audience) seats)\n"
        }
        
        result += "Amount owed is \(usd(statement.totalAmount))\n";
        result += "You earned \(Int(statement.totalVolumeCredits)) credits\n";
        return result;
    }
}

/*
 Requested changes
 1 - statement printed in HTML
 2 - add more play types
 */
