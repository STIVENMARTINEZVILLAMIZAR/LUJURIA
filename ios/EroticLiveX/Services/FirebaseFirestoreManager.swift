import Foundation
import FirebaseFirestore

class FirebaseFirestoreManager: NSObject, ObservableObject {
    private let db = Firestore.firestore()
    
    // MARK: - User Document Operations
    
    func createUserDocument(uid: String, userData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getUserData(uid: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        db.collection("users").document(uid).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists, let data = document.data() {
                completion(.success(data))
            } else {
                let notFoundError = NSError(domain: "UserNotFound", code: 404, userInfo: nil)
                completion(.failure(notFoundError))
            }
        }
    }
    
    func updateUserData(uid: String, updates: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        var updateData = updates
        updateData["updatedAt"] = FieldValue.serverTimestamp()
        
        db.collection("users").document(uid).updateData(updateData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func deleteUserData(uid: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(uid).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // MARK: - Listener for User Updates
    
    func listenToUserData(uid: String, completion: @escaping (Result<[String: Any], Error>) -> Void) -> ListenerRegistration {
        return db.collection("users").document(uid).addSnapshotListener { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists, let data = document.data() {
                completion(.success(data))
            }
        }
    }
}
