//
//  SafetySuggestionsAI.swift
//  HazardCheck5.0
//
//  Created by Emdya P on 10/6/24.
//

import Foundation

struct SafetySuggestionsAI {
    // This function generates safety suggestions based on the average crime rate and other factors.
    func generateSuggestions(for averageCrimeRate: Double, timeOfDay: String, dayOfWeek: String) -> [String] {
        var suggestions: [String] = []
        
        // Suggestions based on crime rate
        if averageCrimeRate > 0.5 {
            suggestions.append("Avoid walking alone at night.")
            suggestions.append("Stay in well-lit areas.")
            suggestions.append("Be aware of your surroundings.")
        } else if averageCrimeRate > 0.2 {
            suggestions.append("Consider using public transportation instead of walking.")
        } else {
            suggestions.append("You are in a relatively safe area.")
        }
        
        // Suggestions based on the time of day
        switch timeOfDay {
        case "Night":
            suggestions.append("Avoid isolated places after dark.")
        case "Morning":
            suggestions.append("Stay alert during early hours.")
        case "Afternoon":
            suggestions.append("It's generally safer during the day.")
        default:
            suggestions.append("Stay cautious.")
        }
        
        // Suggestions based on the day of the week
        switch dayOfWeek {
        case "Saturday", "Sunday":
            suggestions.append("Be extra cautious on weekends when crime rates may rise.")
        case "Friday":
            suggestions.append("Stay vigilant; Friday nights can be unpredictable.")
        default:
            suggestions.append("Weekdays are typically safer, but stay alert.")
        }
        
        return suggestions
    }
}

