////
////  CoreDataTests.swift
////  AnimalsAppTests
////
////  Created by Laura Pinheiro Marson on 21/06/22.
////
//
//import XCTest
//@testable import AnimalsApp
//import CoreData
//
//class CoreDataTests: XCTestCase {
//
//    var coreDataStack: CoreData = .shared
//
//    override func setUp() {
//      super.setUp()
//        coreDataStack.managedContext = ManagedContextMock.build()
//    }
//
//    override func tearDown() {
//      super.tearDown()
//      
//        let storeContainer = persistentContainer.persistentStoreCoordinator
//
//        // Delete each existing persistent store
//        for store in storeContainer.persistentStores {
//            try storeContainer.destroyPersistentStore(
//                at: store.url!,
//                ofType: store.type,
//                options: nil
//            )
//        }
//
//        // Re-create the persistent container
//        persistentContainer = NSPersistentContainer(
//            name: "CoreDataModelFile" // the name of
//            // a .xcdatamodeld file
//        )
//
//        // Calling loadPersistentStores will re-create the
//        // persistent stores
//        persistentContainer.loadPersistentStores {
//            (store, error) in
//            // Handle errors
//        }
//    }
//
//}
