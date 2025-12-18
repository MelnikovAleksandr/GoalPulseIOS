//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Domain

func convertAreaDTOToDomain(_ dto: AreaDTO?) -> Area {
    return Area(
        code: dto?.code ?? "",
        flag: dto?.flag ?? "",
        id: dto?.id ?? -1,
        name: dto?.name ?? ""
    )
}

func convertWinnerDTOToDomain(_ dto: WinnerDTO?) -> Winner {
    return Winner(
        address: dto?.address ?? "",
        clubColors: dto?.clubColors ?? "",
        crest: dto?.crest ?? "",
        founded: dto?.founded ?? 0,
        id: dto?.id ?? -1,
        lastUpdated: dto?.lastUpdated?.description ?? "",
        name: dto?.name ?? "",
        shortName: dto?.shortName ?? "",
        tla: dto?.tla ?? "",
        website: dto?.website ?? "",
        venue: dto?.venue ?? ""
    )
}

func convertCurrentSeasonDTOToDomain(_ dto: CurrentSeasonDTO?) -> CurrentSeason {
    return CurrentSeason(
        currentMatchDay: dto?.currentMatchday ?? 0,
        startDateEndDate: "\(dto?.startDate ?? "")/\(dto?.endDate ?? "")",
        endDate: dto?.endDate ?? "",
        id: dto?.id ?? -1,
        startDate: dto?.startDate ?? "",
        winner: convertWinnerDTOToDomain(dto?.winner)
    )
}

func convertToDomain(_ dto: CompetitionDTO) -> Competition {
    return Competition(
        area: convertAreaDTOToDomain(dto.area),
        code: dto.code ?? "",
        currentSeason: convertCurrentSeasonDTOToDomain(dto.currentSeason),
        emblem: dto.emblem ?? "",
        id: dto.id ?? -1,
        lastUpdated: dto.lastUpdated?.description ?? "",
        name: dto.name ?? "",
        numberOfAvailableSeasons: dto.numberOfAvailableSeasons ?? 0,
        plan: dto.plan?.rawValue ?? "",
        type: dto.type?.rawValue ?? "",
        seasons: []
    )
}
