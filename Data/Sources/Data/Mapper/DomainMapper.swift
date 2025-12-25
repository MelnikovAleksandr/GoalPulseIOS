//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 14.12.2025.
//

import Foundation
import Domain

extension CompetitionEntity {
    func toDomain() -> Competition {
        Competition(
            area: area?.toDomain() ?? Area(code: "", flag: nil, id: abs(UUID().hashValue), name: ""),
            code: code ?? "",
            currentSeason: currentSeason?.toDomain() ?? CurrentSeason(
                currentMatchDay: 0,
                startDateEndDate: "",
                endDate: "",
                id: abs(UUID().hashValue),
                startDate: "",
                winner: nil
            ),
            emblem: URL(string: emblem ?? ""),
            id: id,
            lastUpdated: lastUpdated?.description ?? "",
            name: name ?? "",
            numberOfAvailableSeasons: numberOfAvailableSeasons,
            plan: plan ?? "",
            type: type ?? "",
            seasons: []
        )
    }
}

extension AreaEntity {
    func toDomain() -> Area {
        Area(
            code: code ?? "",
            flag: URL(string: flag ?? ""),
            id: id,
            name: name ?? ""
        )
    }
}

extension TeamEntity {
    func toDomain() -> Team {
        Team(
            address: address ?? "",
            clubColors: clubColors ?? "",
            crest: crest ?? "",
            founded: founded,
            id: id,
            lastUpdated: lastUpdated?.description ?? "",
            name: name ?? "",
            shortName: shortName ?? "",
            tla: tla ?? "",
            website: website ?? "",
            venue: venue ?? ""
        )
    }
}

extension CurrentSeasonEntity {
    func toDomain() -> CurrentSeason {
        CurrentSeason(
            currentMatchDay: currentMatchday,
            startDateEndDate: "\(startDate ?? "")/\(endDate ?? "")",
            endDate: endDate ?? "",
            id: id,
            startDate: startDate ?? "",
            winner: winner?.toDomain() ?? Team(
                address: "",
                clubColors: "",
                crest: "",
                founded: 0,
                id: abs(UUID().hashValue),
                lastUpdated: "",
                name: "",
                shortName: "",
                tla: "",
                website: "",
                venue: ""
            )
        )
    }
}

extension StandingsEntity {
    func toDomain() -> Standings {
        Standings(
            id: id,
            area: area?.toDomain() ?? Area(code: "", flag: nil, id: abs(UUID().hashValue), name: ""),
            competition: competition?.toDomain() ?? Competition(
                area: area?.toDomain() ?? Area(code: "", flag: nil, id: abs(UUID().hashValue), name: ""),
                code: "",
                currentSeason: currentSeason?.toDomain() ?? CurrentSeason(
                    currentMatchDay: 0,
                    startDateEndDate: "",
                    endDate: "",
                    id: abs(UUID().hashValue),
                    startDate: "",
                    winner: nil
                ),
                emblem: nil,
                id: abs(UUID().hashValue),
                lastUpdated: "",
                name: "",
                numberOfAvailableSeasons: 0,
                plan: "",
                type: "",
                seasons: []
            ),
            season: currentSeason?.toDomain() ?? CurrentSeason(
                currentMatchDay: 0,
                startDateEndDate: "",
                endDate: "",
                id: abs(UUID().hashValue),
                startDate: "",
                winner: nil
            ),
            standings: standing.compactMap { $0.toDomain() })
    }
}

extension StandingEntity {
    func toDomain() -> Standing {
        Standing(
            stage: stage ?? "",
            type: type ?? "",
            group: group ?? "",
            table: table.compactMap { $0.toDomain() }
        )
    }
}

extension TableEntity {
    func toDomain() -> Table {
        Table(
            position: position ?? 0,
            team: team?.toDomain(),
            playedGames: playedGames ?? 0,
            form: form ?? "",
            won: won ?? 0,
            draw: draw ?? 0,
            lost: lost ?? 0,
            points: points ?? 0,
            goalsFor: goalsFor ?? 0,
            goalsAgainst: goalsAgainst ?? 0,
            goalDifference: goalDifference ?? 0)
    }
}
