//
//  RealmManager.swift
//  FinalProject
//
//  Created by luong.tran on 09/11/2022.
//

import Foundation
import RealmSwift

protocol RealmManagerType {
    associatedtype RealmObject
}

final class RealmManager: RealmManagerType {

    typealias RealmObject = Object

    static let shared: RealmManager = RealmManager()

    private init() {}

    func addRealm(object: RealmObject) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch { }
    }

    func deleteRealm(object: RealmObject) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object.self)
            }
        } catch { }
    }

    func getDataRealm() -> [Product] {
        do {
            let realm = try Realm()
            return Array(realm.objects(Product.self))
        } catch {
            return []
        }
    }
}
