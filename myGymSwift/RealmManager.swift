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
        //for var index = 0; index < 6; index += 1 {
        for index in 0 ..< 6 {
            RealmManager.SharedInstance.feedDataBaseWithFile(index)
        }
    }
    
    // Remplissage de la base de données avec les stubs
    func feedDataBaseWithFile(_ key: NSInteger) {
        
        returnFileAndObject(key) { (stub, keyStub) -> Void in
            
            self.groupsFromFile(stub, object: keyStub) { (result) -> Void in
                
                switch key {
                    
                case ModelsConstants.stub_sports:
                    self.writeSportsInDB(result)
                case ModelsConstants.stub_sportsDescription:
                    self.writeSportsDescriptionsInDB(result)
                case ModelsConstants.stub_sessions:
                    self.writeSessionsInDB(result)
                case ModelsConstants.stub_objectives:
                    self.writeObjectivesInDB(result)
                default:
                    //print("no stub for key %@",key)
                    break
                }
            }
        }
    }
    
    func writeDataFromWS(_ key: NSInteger,json:JSON, completion:(_ bool:Bool) -> Void) {
        
            switch key {
                
            case ModelsConstants.stub_sessions:
                self.writeSessionsInDB(json)
                //print(self.getAllSessions())
            case ModelsConstants.stub_sports:
                self.writeSportsInDB(json)
                completion(true)
                //print(self.getAllSports())
            case ModelsConstants.stub_sportsDescription:
                self.writeSportsDescriptionsInDB(json)
                completion(true)
                //print(self.getAllSportsDescriptions())
            case ModelsConstants.stub_objectives:
                self.writeObjectivesInDB(json)
            case ModelsConstants.stub_news:
                self.writeNewsInDB(json)
                completion(true)
                //print(self.getAllNews())
            default:
                //print("no ws for key %@",key)
                completion(false)
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
    
    func writeNewsInDB(_ result: JSON) {
        for object in result {
            let newObject = self.generateNews(object.1)
            getNewsWithId(newObject.id, completion: { (new) -> Void in
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
    
    func generateNews(_ dictionary: JSON) -> NewsModel {
        return NewsModel().setData(dictionary)
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
    
    func getAllNewsFromDB(_ completion: (_ news: Array<NewsModel>) -> Void) {
        completion(Array<NewsModel>(realm.objects(NewsModel.self)))
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
    
    func getNewsWithId(_ news_id: String, completion: (_ news: Results<(NewsModel)>) -> Void) {
        completion(realm.objects(NewsModel.self).filter(ModelsConstants.kGetId, news_id))
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
        case ModelsConstants.stub_news:
            completion(ModelsConstants.kNewsStub, ModelsConstants.kNewsObject);
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
