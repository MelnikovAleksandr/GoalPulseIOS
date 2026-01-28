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
            area: area?.toDomain() ?? getEmptyArea(),
            code: code ?? "",
            currentSeason: currentSeason?.toDomain() ?? getEmptySeason(),
            emblem: URL(string: emblem ?? ""),
            id: id,
            lastUpdated: lastUpdated?.description ?? "",
            name: name ?? "",
            numberOfAvailableSeasons: numberOfAvailableSeasons,
            plan: plan ?? "",
            type: Type(rawValue: type ?? "") ?? .LEAGUE,
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
            crest: URL(string: crest ?? ""),
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
            winner: winner?.toDomain() ?? getEmptyTeam()
        )
    }
}

extension StandingsEntity {
    func toDomain() -> Standings {
        Standings(
            id: id,
            area: area?.toDomain() ?? getEmptyArea(),
            competition: competition?.toDomain() ?? getEmptyCompetition(),
            season: currentSeason?.toDomain() ?? getEmptySeason(),
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

extension ScorersEntity {
    func toDomain() -> Scorers {
        Scorers(
            id: id,
            competition: competition?.toDomain() ?? getEmptyCompetition(),
            season: season?.toDomain() ?? getEmptySeason(),
            scorers: scorers.compactMap {
                $0.toDomain()
            }
        )
    }
}

extension ScorerEntity {
    func toDomain() -> Scorer {
        Scorer(
            id: id ?? abs(UUID().hashValue),
            player: player?.toDomain() ?? getEmptyPlayer(),
            team: team?.toDomain() ?? getEmptyTeam(),
            playedMatches: playedMatches ?? 0,
            goals: goals ?? 0,
            assists: assists ?? 0,
            penalties: penalties ?? 0
        )
    }
}

extension PlayerEntity {
    func toDomain() -> Player {
        Player(
            id: id ?? abs(UUID().hashValue),
            name: name ?? "",
            firstName: firstName ?? "",
            lastName: lastName ?? "",
            dateOfBirth: dateOfBirth ?? "",
            nationality: nationality ?? "",
            section: section ?? "",
            shirtNumber: shirtNumber ?? 0
        )
    }
}

extension MatchEntity {
    func toDomain() -> Match {
        Match(
            id: id ?? abs(UUID().hashValue),
            status: status ?? "",
            homeTeam: homeTeam?.toDomain() ?? getEmptyTeam(),
            awayTeam: awayTeam?.toDomain() ?? getEmptyTeam(),
            score: score?.toDomain() ?? getEmptyScore(),
            dateTime: utcDate ?? Date()
        )
    }
}

extension ScoreEntity {
    func toDomain() -> Score {
        Score(winner: winner.toWinner(), time: fullTime?.toDomain() ?? getEmptyTime())
    }
}

extension Optional where Wrapped == String {
    func toWinner() -> Winner {
        guard let self = self else { return .none }
        switch self {
        case "AWAY_TEAM": return .away
        case "DRAW": return .draw
        case "HOME_TEAM": return .home
        default: return .none
        }
    }
}


extension TimeEntity {
    func toDomain() -> Time {
        Time(home: home ?? 0, away: away ?? 0)
    }
}

func getEmptyPlayer() -> Player {
    return Player(
        id: abs(UUID().hashValue),
        name: "",
        firstName: "",
        lastName: "",
        dateOfBirth: "",
        nationality: "",
        section: "",
        shirtNumber: 0
    )
}

func getEmptyTeam() -> Team {
    return Team(
        address: "",
        clubColors: "",
        crest: nil,
        founded: 0,
        id: abs(UUID().hashValue),
        lastUpdated: "",
        name: "",
        shortName: "",
        tla: "",
        website: "",
        venue: ""
    )
}

func getEmptyArea() -> Area {
    return Area(code: "", flag: nil, id: abs(UUID().hashValue), name: "")
}

func getEmptySeason() -> CurrentSeason {
    return CurrentSeason(
        currentMatchDay: 0,
        startDateEndDate: "",
        endDate: "",
        id: abs(UUID().hashValue),
        startDate: "",
        winner: nil
    )
}

func getEmptyCompetition() -> Competition {
    return Competition(
        area: getEmptyArea(),
        code: "",
        currentSeason: getEmptySeason(),
        emblem: nil,
        id: abs(UUID().hashValue),
        lastUpdated: "",
        name: "",
        numberOfAvailableSeasons: 0,
        plan: "",
        type: .LEAGUE,
        seasons: []
    )
}

func getEmptyTime() -> Time {
    Time(home: 0, away: 0)
}

func getEmptyScore() -> Score {
    Score(winner: .none, time: getEmptyTime())
}
