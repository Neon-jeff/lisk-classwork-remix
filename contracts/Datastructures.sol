// SPDX-License-Identifier: MIT


pragma solidity ^0.8.20;

contract DataStructures{

    enum Status {
        Pending,
        InProgress,
        Completed
    }
    struct Todo{
        uint id;
        string content;
        Status status;
    }

    mapping(uint => Todo)  todos ;

    uint[] todoIDs;

    event NewTodoAdded(uint ID, string message);

    // modifier to check if ID exists in the todoIDs array

    modifier checkID(uint _id){
        require(_id > 0 && _id <= todoIDs.length, "DataStructures: Todo ID not found");
        _;
    }

    function addTodo(string memory _content) public {
        uint newID = todoIDs.length + 1;
        todos[newID] = Todo(newID,_content,Status.Pending);
        todoIDs.push(newID);
        emit NewTodoAdded(newID, "New todo item added");
    }

    function updateTodo(uint _id, Status _status) checkID(_id) public {
        Todo memory _todo = todos[_id];
        _todo.status = _status;
        todos[_id] = _todo;
    }

    function getTodo(uint _id) checkID(_id) view public  returns (Todo memory)  {
        
        return todos[_id];
    }
}