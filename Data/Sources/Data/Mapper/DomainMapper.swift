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
            area: area?.toDomain() ?? Area(code: "", flag: "", id: -1, name: ""),
            code: code ?? "",
            currentSeason: currentSeason?.toDomain() ?? CurrentSeason(
                currentMatchDay: 0,
                startDateEndDate: "",
                endDate: "",
                id: -1,
                startDate: "",
                winner: Winner(
                    address: "",
                    clubColors: "",
                    crest: "",
                    founded: 0,
                    id: -1,
                    lastUpdated: "",
                    name: "",
                    shortName: "",
                    tla: "",
                    website: "",
                    venue: ""
                )
            ),
            emblem: emblem ?? "",
            id: Int(id),
            lastUpdated: lastUpdated?.description ?? "",
            name: name ?? "",
            numberOfAvailableSeasons: Int(numberOfAvailableSeasons),
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
            flag: flag ?? "",
            id: Int(id),
            name: name ?? ""
        )
    }
}

extension WinnerEntity {
    func toDomain() -> Winner {
        Winner(
            address: address ?? "",
            clubColors: clubColors ?? "",
            crest: crest ?? "",
            founded: Int(founded),
            id: Int(id),
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
            currentMatchDay: Int(currentMatchday),
            startDateEndDate: "\(startDate ?? "")/\(endDate ?? "")",
            endDate: endDate ?? "",
            id: Int(id),
            startDate: startDate ?? "",
            winner: winner?.toDomain() ?? Winner(
                address: "",
                clubColors: "",
                crest: "",
                founded: 0,
                id: -1,
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
