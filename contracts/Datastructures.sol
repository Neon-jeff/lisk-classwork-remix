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
        // check if lenght of ID array is zero and assign one as the initial ID
        uint todoLength = todoIDs.length;
        if(todoLength == 0){
            todoIDs.push(1);
            todos[1] = Todo(1,_content,Status.Pending);
            emit NewTodoAdded(1, "New todo item added");
            return ;
        }
        todoIDs.push(todoLength + 1);
        todos[todoLength+1] = Todo(todoLength + 1,_content,Status.Pending);
        emit NewTodoAdded(todoLength+1, "New todo item added");
        return ;
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