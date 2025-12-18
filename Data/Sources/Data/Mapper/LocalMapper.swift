//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 14.12.2025.
//

import Foundation
import RealmSwift

extension CompetitionEntity {
    static func from(dto: CompetitionDTO) -> CompetitionEntity {
        let entity = CompetitionEntity()
        entity.id = Int64(dto.id ?? -1)
        entity.name = dto.name
        entity.code = dto.code
        entity.emblem = dto.emblem
        entity.type = dto.type?.rawValue
        entity.plan = dto.plan?.rawValue
        entity.numberOfAvailableSeasons = Int64(dto.numberOfAvailableSeasons ?? 0)
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
        entity.id = Int64(dto.id ?? -1)
        entity.name = dto.name
        entity.code = dto.code
        entity.flag = dto.flag
        return entity
    }
}

extension WinnerEntity {
    static func from(dto: WinnerDTO?) -> WinnerEntity? {
        guard let dto = dto else { return nil }
        let entity = WinnerEntity()
        entity.id = Int64(dto.id ?? -1)
        entity.name = dto.name
        entity.shortName = dto.shortName
        entity.tla = dto.tla
        entity.crest = dto.crest
        entity.address = dto.address
        entity.website = dto.website
        entity.founded = Int64(dto.founded ?? 0)
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
        entity.id = Int64(dto.id ?? -1)
        entity.startDate = dto.startDate
        entity.endDate = dto.endDate
        entity.currentMatchday = Int64(dto.currentMatchday ?? 0)
        entity.winner = WinnerEntity.from(dto: dto.winner)
        return entity
    }
}
