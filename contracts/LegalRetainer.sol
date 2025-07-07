// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LegalRetainer {
    address public client;
    address public lawyer;
    uint256 public retainerAmount;
    uint256 public depositedAmount;
    uint256 public hoursWorked;
    uint256 public hourlyRate;
    bool public isTerminated;

    enum RequestStatus { Pending, Approved, Rejected }

    struct PaymentRequest {
        uint256 amount;
        string description;
        RequestStatus status;
    }

    PaymentRequest[] public requests;

    modifier onlyClient() {
        require(msg.sender == client, "Not authorized");
        _;
    }

    modifier onlyLawyer() {
        require(msg.sender == lawyer, "Not authorized");
        _;
    }

    modifier notTerminated() {
        require(!isTerminated, "Contract terminated");
        _;
    }

    constructor(address _lawyer, uint256 _hourlyRate, uint256 _retainerAmount) {
        client = msg.sender;
        lawyer = _lawyer;
        hourlyRate = _hourlyRate;
        retainerAmount = _retainerAmount;
    }

    receive() external payable {
        require(msg.sender == client, "Only client can deposit");
        require(msg.value + depositedAmount <= retainerAmount, "Over deposit");
        depositedAmount += msg.value;
    }

    function logWorkAndRequestPayment(uint256 _hours, string memory _desc) external onlyLawyer notTerminated {
        uint256 paymentAmount = _hours * hourlyRate;
        require(paymentAmount <= depositedAmount, "Insufficient funds");

        requests.push(PaymentRequest({
            amount: paymentAmount,
            description: _desc,
            status: RequestStatus.Pending
        }));
    }

    function approveRequest(uint256 index) external onlyClient notTerminated {
        PaymentRequest storage request = requests[index];
        require(request.status == RequestStatus.Pending, "Already handled");

        request.status = RequestStatus.Approved;
        depositedAmount -= request.amount;
        payable(lawyer).transfer(request.amount);
    }

    function rejectRequest(uint256 index) external onlyClient notTerminated {
        PaymentRequest storage request = requests[index];
        require(request.status == RequestStatus.Pending, "Already handled");

        request.status = RequestStatus.Rejected;
    }

    function terminateContract() external onlyClient notTerminated {
        isTerminated = true;

        if (depositedAmount > 0) {
            payable(client).transfer(depositedAmount);
            depositedAmount = 0;
        }
    }

    function getRequestCount() external view returns (uint256) {
        return requests.length;
    }

    function getRequest(uint256 index) external view returns (
        uint256 amount,
        string memory description,
        RequestStatus status
    ) {
        PaymentRequest memory req = requests[index];
        return (req.amount, req.description, req.status);
    }
}
