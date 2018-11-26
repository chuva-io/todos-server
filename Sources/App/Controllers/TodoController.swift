import Vapor
import Fluent

final class TodoController {

    // Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Todo]> {
        guard let isCompletedQuery = try? req
            .query
            .get(Bool.self, at: ["isCompleted"])
            else {
                return Todo.query(on: req).all()
        }
        return Todo
            .query(on: req)
            .filter(\.isCompleted == isCompletedQuery)
            .all()
    }

    // Create `Todo` from request body.
    func create(_ req: Request, todo: Todo) throws -> Future<Todo> {
        return todo.save(on: req)
    }

    // Delete a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req
            .parameters
            .next(Todo.self)
            .flatMap { todo in
                return todo.delete(on: req)
            }.transform(to: .ok)
    }
}
