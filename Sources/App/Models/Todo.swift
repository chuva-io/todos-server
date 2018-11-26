import FluentSQLite
import Vapor

final class Todo: SQLiteModel {
    var id: Int?
    var title: String
    var isCompleted: Bool = false
    
    init(id: Int? = nil, title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration { }

// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content { }

// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter { }
