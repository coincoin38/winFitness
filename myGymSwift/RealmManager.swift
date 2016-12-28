//
//  RealmManager.swift
//  myGymSwift
//
//  Created by julien gimenez on 29/11/2015.
//  Copyright © 2015 julien gimenez. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class RealmManager: NSObject {

    let realm = try! Realm()
    
    static let SharedInstance = RealmManager()
    
    // MARK: - Generateur d'objets
    
    func startFeed(){
        
        self.startFeedSessionsByDay()
        self.startFeedSports()
        self.startFeedSportsDescriptions()
        self.startFeedObjectives()
    }
    
    func startFeedSessionsByDay(){
        
        self.groupsFromFile("Lundi",object: ModelsConstants.kSessionsObject) { (JSON) in
            self.writeSessionsInDB(JSON)
        }
        self.groupsFromFile("Mardi",object: ModelsConstants.kSessionsObject) { (JSON) in
            self.writeSessionsInDB(JSON)
        }
        self.groupsFromFile("Mercredi",object: ModelsConstants.kSessionsObject) { (JSON) in
            self.writeSessionsInDB(JSON)
        }
        self.groupsFromFile("Jeudi",object: ModelsConstants.kSessionsObject) { (JSON) in
            self.writeSessionsInDB(JSON)
        }
        self.groupsFromFile("Vendredi",object: ModelsConstants.kSessionsObject) { (JSON) in
            self.writeSessionsInDB(JSON)
        }
        self.groupsFromFile("Samedi",object: ModelsConstants.kSessionsObject) { (JSON) in
            self.writeSessionsInDB(JSON)
        }
    }
    
    func startFeedSports (){
        
        self.groupsFromFile(ModelsConstants.kSportsStub,object: ModelsConstants.kSportsObject) { (JSON) in
            self.writeSportsInDB(JSON)
        }
    }

    func startFeedSportsDescriptions (){
        
        self.groupsFromFile(ModelsConstants.kSportsDescritpionsStub,object: ModelsConstants.kSportsDescriptionsObject) { (JSON) in
            self.writeSportsDescriptionsInDB(JSON)
        }
    }
    
    func startFeedObjectives (){
        
        self.groupsFromFile(ModelsConstants.kObjectivesStub,object: ModelsConstants.kObjectivesObject) { (JSON) in
            self.writeObjectivesInDB(JSON)
        }
    }

    // MARK: - Ecriture d'objets dans la DB

    func writeSessionsInDB(_ result: JSON) {
        for object in result {
            let newObject = self.generateSession(object.1)
            getSessionWithId(newObject.id, completion: { (new) -> Void in
                if (new.count==0){
                    self.writeData(newObject)
                }
                else {
                    let realm = try! Realm()
                    try! realm.write {
                        new[0].sport_id = newObject.sport_id
                        new[0].from = newObject.from
                        new[0].duration = newObject.duration
                        new[0].attendance = newObject.attendance
                        new[0].day = newObject.day
                    }
                }
            })
        }
    }
    
    func writeSportsInDB(_ result: JSON) {
        for object in result {
            let newObject = self.generateSport(object.1)
            getSportWithId(newObject.id, completion: { (new) -> Void in
                if (new.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeSportsDescriptionsInDB(_ result: JSON) {
        for object in result {
            let newObject = self.generateSportDescription(object.1)
            getSportDescriptionWithId(newObject.key_sport, completion: { (new) -> Void in
                if (new.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeObjectivesInDB(_ result: JSON) {
        for object in result {
            let newObject = self.generateObjectives(object.1)
            getObjectivesWithId(newObject.id, completion: { (new) -> Void in
                if (new.count==0){
                    self.writeData(newObject)
                }
            })
        }
    }
    
    func writeData(_ object:Object){
        try! self.realm.write {
            self.realm.add(object)
        }
    }
    
    // MARK: - Génération d'objets

    func generateSession(_ dictionary: JSON) -> SessionModel {
        return SessionModel().setData(dictionary)
    }

    func generateSport(_ dictionary: JSON) -> SportModel {
        return SportModel().setData(dictionary)
    }
    
    func generateSportDescription(_ dictionary: JSON) -> SportDescriptionModel {
        return SportDescriptionModel().setData(dictionary)
    }
    
    func generateObjectives(_ dictionary: JSON) -> ObjectiveModel {
        return ObjectiveModel().setData(dictionary)
    }
    
    // MARK: - Récupération d'objets

    func getAllSessions() -> Results<(SessionModel)> {
        return realm.objects(SessionModel.self)
    }
    
    func getAllSports() -> Results<(SportModel)> {
        return realm.objects(SportModel.self)
    }
    
    func getAllSportsDescriptions() -> Results<(SportDescriptionModel)> {
        return realm.objects(SportDescriptionModel.self)
    }
    
    func getAllSportsFromDB(_ completion: (_ sports: Array<(SportModel)>) -> Void) {
        completion(Array<SportModel>(realm.objects(SportModel.self)))
    }
    
    func getAllObjectives()->Results<(ObjectiveModel)>{
        return realm.objects(ObjectiveModel.self)
    }
    
    // MARK : - Recherches
    
    func isSessionWithDate(_ day: String, completion: (_ sessions: Results<(SessionModel)>) -> Void) {
        completion(realm.objects(SessionModel.self).filter(ModelsConstants.kGetDay, day))
    }
    
    func getSessionWithId(_ id: String, completion: (_ session: Results<(SessionModel)>) -> Void) {
        completion(realm.objects(SessionModel.self).filter(ModelsConstants.kGetId, id))
    }
    
    func getSportWithId(_ id: String, completion: (_ sport: Results<(SportModel)>) -> Void) {
        completion(realm.objects(SportModel.self).filter(ModelsConstants.kGetId, id))
    }
    
    func getSportDescriptionWithId(_ _id: String, completion: (_ description: Results<(SportDescriptionModel)>) -> Void) {
        completion(realm.objects(SportDescriptionModel.self).filter(ModelsConstants.kGetKey_sport, _id))
    }
    
    func getObjectivesWithId(_ id: String, completion: (_ objectives: Results<(ObjectiveModel)>) -> Void) {
        completion(realm.objects(ObjectiveModel.self).filter(ModelsConstants.kGetId, id))
    }
    
    func getObjectivesWithSportId(_ sport_id: String, completion: (_ objectives: Results<(ObjectiveModel)>) -> Void) {
        completion(realm.objects(ObjectiveModel.self).filter(ModelsConstants.kGetSportId, sport_id))
    }
    
    // MARK: - Suppression de la base de données

    func cleanDb() {
        try! realm.write {
            self.realm.deleteAll()
        }
    }
    
    // MARK: - Traitement JSON

    func returnFileAndObject(_ keyStubDetection: NSInteger, completion: (_ stub: String, _ keyStub: String) -> Void) {
        
        switch keyStubDetection{
            
        case ModelsConstants.stub_sessions:
            completion(ModelsConstants.kSessionsStub, ModelsConstants.kSessionsObject);
        case ModelsConstants.stub_sports:
            completion(ModelsConstants.kSportsStub, ModelsConstants.kSportsObject);
        case ModelsConstants.stub_sportsDescription:
            completion(ModelsConstants.kSportsDescritpionsStub, ModelsConstants.kSportsDescriptionsObject);
        case ModelsConstants.stub_objectives:
            completion(ModelsConstants.kObjectivesStub, ModelsConstants.kObjectivesObject);
        default:
            completion("", "");
        }
    }
    
    // Transformation d'un stub en data JSON
    func groupsFromFile(_ fileName: String, object: String, completion: (_ result: JSON) -> Void) {
        
        let path = Bundle.main.path(forResource: fileName, ofType: ModelsConstants.kJsonExtension)
        let dataJson = try? Data(contentsOf: URL(fileURLWithPath: path!))
        let json = JSON(data: dataJson!)
        completion(json[object])
    }
}
