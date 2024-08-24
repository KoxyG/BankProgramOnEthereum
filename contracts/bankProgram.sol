// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.2 <0.9.0;


contract BankProgram {
   

    event Withdrawal(address indexed to, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);
    event NewAccount(address indexed account);  


    struct Account {
        uint balance;
        string name;
        string email;
        bool exists;
    }
    mapping(address => Account) public accounts;


    // create an account
    function create_account(string memory name, string memory email) public payable{  

       require(!accounts[msg.sender].exists, "Account already exists");
       require(msg.value >= 0, "Insufficient funds to create account");
      
        
        Account memory create = Account(
            {
                balance: 0,
                name: name,
                email: email,
                exists: true
            }
        );
        accounts[msg.sender] = create;
        deposit(msg.sender);
        emit NewAccount(msg.sender);

    }

    // deposit into account ether
    function deposit(address _addre) public payable {

        require(accounts[_addre].exists, "Account does not exist");
        require(msg.value > 0, "Deposit amount must be greater than 0");

        accounts[_addre].balance += msg.value;
        emit Deposit(_addre, msg.value);
    }

    // transfer from account into another account that has been created
    function transfer_from(address payable to) public payable {
        require(accounts[msg.sender].exists, "Account does not exist");
        require(accounts[to].exists, "Recipient account does not exist");

        require(accounts[msg.sender].balance >= msg.value, "Insufficient funds to transfer");

        deposit(to);
        accounts[msg.sender].balance -= msg.value;

        emit Transfer(msg.sender, to, msg.value);
    }

    // withdraw from bank into your wallet
    function withdraw(uint amount) public payable {
        require(accounts[msg.sender].exists, "Account does not exist");
        require(accounts[msg.sender].balance >= amount, "Insufficient funds to withdraw");

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether");
    }
}
