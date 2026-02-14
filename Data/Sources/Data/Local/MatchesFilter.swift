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
        
        let sortedStages = groupedMatches.keys.sorted {
            guard let stage1 = $0, let stage2 = $1 else { return false }
            return stage1 < stage2
        }
        
        for stage in sortedStages {
            guard let matchesByStage = groupedMatches[stage] else { continue }
            let matchesByTourEntities = Dictionary(grouping: matchesByStage, by: { $0.matchday })
            let sortedMatchdays = matchesByTourEntities.keys.sorted { (matchday1, matchday2) -> Bool in
                return (matchday1 ?? 0) > (matchday2 ?? 0)
            }
            
            for matchday in sortedMatchdays {
                guard let matchesByMatchday = matchesByTourEntities[matchday] else { continue }
                
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
    
}
