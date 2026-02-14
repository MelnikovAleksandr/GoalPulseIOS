//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 14.12.2025.
//

import Foundation
import RealmSwift

extension CompetitionEntity {
    static func from(dto: CompetitionDTO?) -> CompetitionEntity? {
        guard let dto = dto else { return nil }
        let entity = CompetitionEntity()
        entity.id = dto.id ?? abs(UUID().hashValue)
        entity.name = dto.name
        entity.code = dto.code
        entity.emblem = dto.emblem
        entity.type = dto.type
        entity.numberOfAvailableSeasons = dto.numberOfAvailableSeasons ?? 0
        entity.lastUpdated = dto.lastUpdated
        entity.area = AreaEntity.from(dto: dto.area)
        entity.currentSeason = CurrentSeasonEntity.from(dto: dto.currentSeason)
        return entity
    }
}

extension AreaEntity {
    static func from(dto: AreaDTO?) -> AreaEntity? {
        guard let dto = dto else { return nil }
        let entity = AreaEntity()
        entity.id = dto.id ?? abs(UUID().hashValue)
        entity.name = dto.name
        entity.code = dto.code
        entity.flag = dto.flag
        return entity
    }
}

extension TeamEntity {
    static func from(dto: TeamDTO?) -> TeamEntity? {
        guard let dto = dto else { return nil }
        let entity = TeamEntity()
        entity.id = dto.id ?? abs(UUID().hashValue)
        entity.name = dto.name
        entity.shortName = dto.shortName
        entity.tla = dto.tla
        entity.crest = dto.crest
        entity.address = dto.address
        entity.website = dto.website
        entity.founded = dto.founded ?? 0
        entity.clubColors = dto.clubColors
        entity.venue = dto.venue
        entity.lastUpdated = dto.lastUpdated
        return entity
    }
}

extension CurrentSeasonEntity {
    static func from(dto: CurrentSeasonDTO?) -> CurrentSeasonEntity? {
        guard let dto = dto else { return nil }
        let entity = CurrentSeasonEntity()
        entity.id = dto.id ?? abs(UUID().hashValue)
        entity.startDate = dto.startDate
        entity.endDate = dto.endDate
        entity.currentMatchday = dto.currentMatchday ?? 0
        entity.winner = TeamEntity.from(dto: dto.winner)
        return entity
    }
}

extension StandingsEntity {
    static func from(dto: StandingsDTO?) -> StandingsEntity? {
        guard let dto = dto else { return nil }
        let entity = StandingsEntity()
        entity.id = dto.competition?.code ?? UUID().uuidString
        entity.area = AreaEntity.from(dto: dto.area)
        entity.competition = CompetitionEntity.from(dto: dto.competition)
        entity.currentSeason = CurrentSeasonEntity.from(dto: dto.season)
        entity.standing.append(objectsIn: dto.standings?.compactMap { StandingEntity.from(dto: $0) } ?? [])
        return entity
    }
    
}

extension StandingEntity {
    static func from(dto: StandingDTO?) -> StandingEntity? {
        guard let dto = dto else { return nil }
        let entity = StandingEntity()
        entity.stage = dto.stage
        entity.type = dto.type
        entity.group = dto.group
        entity.table.append(objectsIn: dto.table?.compactMap { TableEntity.from(dto: $0) } ?? [])
        return entity
    }
}

extension TableEntity {
    static func from(dto: TableDTO?) -> TableEntity? {
        guard let dto = dto else { return nil }
        let entity = TableEntity()
        entity.position = dto.position
        entity.playedGames = dto.playedGames
        entity.form = dto.form
        entity.won = dto.won
        entity.draw = dto.draw
        entity.lost = dto.lost
        entity.points = dto.points
        entity.goalsFor = dto.goalsFor
        entity.goalsAgainst = dto.goalsAgainst
        entity.goalDifference = dto.goalDifference
        entity.team = TeamEntity.from(dto: dto.team)
        return entity
    }
}

extension ScorersEntity {
    static func from(dto: ScorersDTO?) -> ScorersEntity? {
        guard let dto = dto else { return nil }
        let entity = ScorersEntity()
        entity.id = dto.competition?.code ?? UUID().uuidString
        entity.competition = CompetitionEntity.from(dto: dto.competition)
        entity.season = CurrentSeasonEntity.from(dto: dto.season)
        entity.scorers.append(objectsIn: dto.scorers?.compactMap { scorer in
            ScorerEntity.from(dto: scorer)
        } ?? [])
        return entity
    }
}

extension ScorerEntity {
    static func from(dto: ScorerDTO?) -> ScorerEntity? {
        guard let dto = dto else { return nil }
        let entity = ScorerEntity()
        entity.id = dto.player?.id
        entity.team = TeamEntity.from(dto: dto.team)
        entity.player = PlayerEntity.from(dto: dto.player)
        entity.playedMatches = dto.playedMatches
        entity.goals = dto.goals
        entity.assists = dto.assists
        entity.penalties = dto.penalties
        return entity
    }
}

extension PlayerEntity {
    static func from(dto: PlayerDTO?) -> PlayerEntity? {
        guard let dto = dto else { return nil }
        let entity = PlayerEntity()
        entity.id = dto.id
        entity.name = dto.name
        entity.firstName = dto.firstName
        entity.lastName = dto.lastName
        entity.dateOfBirth = dto.dateOfBirth
        entity.nationality = dto.nationality
        entity.section = dto.section
        entity.shirtNumber = dto.shirtNumber
        entity.lastUpdated = dto.lastUpdated
        return entity
    }
}

extension MatchesEntity {
    static func from(dto: MatchesDTO?) -> MatchesEntity? {
        guard let dto = dto else { return nil }
        let entity = MatchesEntity()
        entity.id = dto.competition?.code ?? UUID().uuidString
        entity.competition = CompetitionEntity.from(dto: dto.competition)
        entity.matches.append(objectsIn: dto.matches?.compactMap { match in
            MatchEntity.from(dto: match)
        } ?? [])
        return entity
    }
    
    static func fromTeam(dto: MatchesDTO?, teamId: Int) -> MatchesEntity? {
        guard let dto = dto else { return nil }
        let entity = MatchesEntity()
        entity.id = String(teamId)
        entity.competition = CompetitionEntity.from(dto: dto.competition)
        entity.matches.append(objectsIn: dto.matches?.compactMap { match in
            MatchEntity.from(dto: match)
        } ?? [])
        return entity
    }
}

extension MatchEntity {
    static func from(dto: MatchDTO?) -> MatchEntity? {
        guard let dto = dto else { return nil }
        let entity = MatchEntity()
        entity.area = AreaEntity.from(dto: dto.area)
        entity.competition = CompetitionEntity.from(dto: dto.competition)
        entity.homeTeam = TeamEntity.from(dto: dto.homeTeam)
        entity.awayTeam = TeamEntity.from(dto: dto.awayTeam)
        entity.id = dto.id
        entity.utcDate = dto.utcDate
        entity.status = dto.status
        entity.matchday = dto.matchday
        entity.stage = dto.stage
        entity.lastUpdated = dto.lastUpdated
        entity.score = ScoreEntity.from(dto: dto.score)
        entity.referees.append(objectsIn: dto.referees?.compactMap { referee in
            RefereeEntity.from(dto: referee)
        } ?? [])
        return entity
    }
}

extension ScoreEntity {
    static func from(dto: ScoreDTO?) -> ScoreEntity? {
        guard let dto = dto else { return nil }
        let entity = ScoreEntity()
        entity.winner = dto.winner
        entity.duration = dto.duration
        entity.fullTime = TimeEntity.from(dto: dto.fullTime)
        entity.halfTime = TimeEntity.from(dto: dto.halfTime)
        return entity
    }
}

extension TimeEntity {
    static func from(dto: TimeDTO?) -> TimeEntity? {
        guard let dto = dto else { return nil }
        let entity = TimeEntity()
        entity.home = dto.home
        entity.away = dto.away
        return entity
    }
}

extension RefereeEntity {
    static func from(dto: RefereeDTO?) -> RefereeEntity? {
        guard let dto = dto else { return nil }
        let entity = RefereeEntity()
        entity.id = dto.id
        entity.name = dto.name
        entity.type = dto.type
        entity.nationality = dto.nationality
        return entity
    }
}

extension TeamInfoEntity {
    static func from(dto: TeamDTO?) -> TeamInfoEntity? {
        guard let dto = dto else { return nil }
        let entity = TeamInfoEntity()
        entity.id = dto.id ?? abs(UUID().hashValue)
        entity.name = dto.name
        entity.shortName = dto.shortName
        entity.tla = dto.tla
        entity.crest = dto.crest
        entity.address = dto.address
        entity.website = dto.website
        entity.founded = dto.founded ?? 0
        entity.clubColors = dto.clubColors
        entity.area = AreaEntity.from(dto: dto.area)
        entity.venue = dto.venue
        entity.lastUpdated = dto.lastUpdated
        entity.coach = PersonEntity.from(dto: dto.coach)
        entity.squad.append(objectsIn: dto.squad?.compactMap { person in
            PersonEntity.from(dto: person)
        } ?? [])
        return entity
    }
}

extension PersonEntity {
    static func from(dto: PersonDTO?) -> PersonEntity? {
        guard let dto = dto else { return nil }
        let entity = PersonEntity()
        entity.id = dto.id
        entity.name = dto.name
        entity.firstName = dto.firstName
        entity.lastName = dto.lastName
        entity.dateOfBirth = dto.dateOfBirth?.toDate()
        entity.nationality = dto.nationality
        entity.position = dto.position
        entity.contract = ContractEntity.from(dto: dto.contract)
        return entity
    }
}

extension ContractEntity {
    static func from(dto: ContractDTO?) -> ContractEntity? {
        guard let dto = dto else { return nil }
        let entity = ContractEntity()
        entity.start = dto.start.flatMap { $0.toDate() }
        entity.until = dto.until.flatMap { $0.toDate() }
        return entity
    }
}

extension String {
    func toDate() -> Date? {
        let formats = ["yyyy-MM-dd", "yyyy-MM"]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: self) {
                return date
            }
        }
        return nil
    }
}
