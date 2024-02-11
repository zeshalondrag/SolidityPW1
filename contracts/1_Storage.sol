// SPDX-License-Identifier: GPL-3.0
// Первая строчка - лицензия

pragma solidity >=0.7.0 <0.9.0;

contract MyShop {
    // Структура для хранения информации о пользователе
    struct User {
        address userAddress;
        uint256 balance;
    }

    // Массив для хранения пользователей
    User[] public users;

    // Событие, которое регистрирует каждое пополнение баланса
    event Paid(address _from, uint256 _amount);
    event BalanceAdded(address _user, uint256 _amount);
    event Withdrawal(address _to, uint256 _amount);

    // Функция, позволяющая пользователям отправлять эфиры на контракт
    function pay() public payable {
        // Проверка на отправку значения больше 0
        require(msg.value > 0, "Value must be greater than 0");
        emit Paid(msg.sender, msg.value);
        emit BalanceAdded(msg.sender, msg.value);
    }

    // Функция, возвращающая баланс контракта
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Функция для вывода средств из смарт-контракта с проверкой наличия достаточного баланса для вывода
    function withdraw(uint256 _amount) public {
        // Проверка наличия достаточного баланса для вывода
        require(_amount <= address(this).balance, "Insufficient balance");
        // Проверка на отправку значения больше 0
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }
}