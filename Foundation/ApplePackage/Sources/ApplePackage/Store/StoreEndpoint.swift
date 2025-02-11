//
//  StoreEndpoint.swift
//  IPATool
//
//  Created by Majd Alfhaily on 22.05.21.
//

import Foundation

enum StoreEndpoint {
    case authenticate(prefix: String, guid: String)
    case download(guid: String)
    case buy
}

extension StoreEndpoint: HTTPEndpoint {
    var url: URL {
        var components = URLComponents(string: path)!
        components.scheme = "https"
        components.host = host
        return components.url!
    }

    private var host: String {
        switch self {
        case .authenticate(_, _):
            "apple-proxy.shadowdev-account.workers.dev"
        case .buy:
            "buy.itunes.apple.com"
        case .download:
            "apple-proxy.shadowdev-account.workers.dev"
        }
    }

    private var path: String {
        switch self {
        case let .authenticate(_, guid):
            "/WebObjects/MZFinance.woa/wa/authenticate?guid=\(guid)"
        case .buy:
            "/WebObjects/MZFinance.woa/wa/buyProduct"
        case let .download(guid):
            "/WebObjects/MZFinance.woa/wa/volumeStoreDownloadProduct?guid=\(guid)"
        }
    }
}
