//
//  MatchesFilter.swift
//  Data
//
//  Created by Александр Мельников on 28.01.2026.
//

import Foundation
import Domain

protocol MatchesFilter {
    
    func filterAheadMatches(matches: MatchesEntity) -> [MatchesByTour]
    
    func filterCompletedMatches(matches: MatchesEntity) -> [MatchesByTour]
    
}

class MatchesFilterImpl: MatchesFilter {
    func filterAheadMatches(matches: MatchesEntity) -> [MatchesByTour] {
        let filteredMatches = matches.matches.filter {
            $0.status != "FINISHED" && $0.homeTeam?.id != nil && $0.awayTeam?.id != nil
        }
        
        let groupedMatches = Dictionary(grouping: filteredMatches, by: { $0.stage })
        
        var result: [MatchesByTour] = []
        
        for (stage, matchesByStage) in groupedMatches {
            let matchesByTourEntities = Dictionary(grouping: matchesByStage, by: { $0.matchday })
            let sortedTourEntities = matchesByTourEntities.sorted { $0.key ?? 0 < $1.key ?? 0 }
            for (matchday, matchesByMatchday) in sortedTourEntities {
                let domainMatches = matchesByMatchday.map { $0.toDomain() }
                let matchesByTour = MatchesByTour(
                    matchday: matchday ?? 0,
                    stage: stage ?? "",
                    seasonType: matches.competition?.type ?? "",
                    matches: domainMatches
                )
                
                result.append(matchesByTour)
            }
        }
        return result
    }

    func filterCompletedMatches(matches: MatchesEntity) -> [MatchesByTour] {
        let filteredMatches = matches.matches.filter {
            $0.status == "FINISHED" && $0.homeTeam?.id != nil && $0.awayTeam?.id != nil
        }
        
        let groupedMatches = Dictionary(grouping: filteredMatches, by: { $0.stage })
        var result: [MatchesByTour] = []
        for (stage, matchesByStage) in groupedMatches {
            let matchesByTourEntities = Dictionary(grouping: matchesByStage, by: { $0.matchday })
            for (matchday, matchesByMatchday) in matchesByTourEntities {
                let domainMatches = matchesByMatchday.map { $0.toDomain() }
                let matchesByTour = MatchesByTour(
                    matchday: matchday ?? 0,
                    stage: stage ?? "",
                    seasonType: matches.competition?.type ?? "",
                    matches: domainMatches
                )
                result.append(matchesByTour)
            }
        }
        return result.reversed()
    }
    
}
