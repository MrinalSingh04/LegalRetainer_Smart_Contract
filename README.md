# 🧑‍⚖️ LegalRetainer Smart Contract

A secure and transparent Ethereum smart contract designed to manage legal retainer agreements between a **client** and a **lawyer**, ensuring accountability, time-based billing, and fair payment workflows.

---

## 🔍 What is LegalRetainer?

**LegalRetainer** is a smart contract that simulates a real-world legal services agreement on the blockchain. In traditional legal retainers:
- A client pays a fixed retainer amount upfront.
- The lawyer logs billable hours.
- Payment is only made when the client approves it.

This contract brings that entire workflow **on-chain** — making it trustless, auditable, and programmable.

---

## 🧠 Why LegalRetainer?

✅ **Trustless Billing**: No need for manual invoicing and bank transfers.

✅ **Client Control**: Client must approve each payment request.

✅ **On-chain Record**: Work logs and payments are transparently recorded.

✅ **Auto Refund**: Unused funds are refunded if the contract is terminated.

✅ **Complex Logic**: Involves role-based access, dynamic fund flow, request approval system, and termination logic — a great example of intermediate smart contract design.

---

## ⚙️ Features

| Feature                     | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| Retainer Deposit           | Client deposits an agreed retainer amount.                                  |
| Time Logging & Requests    | Lawyer logs hours and raises payment requests with descriptions.            |
| Client Approval            | Client manually approves (or rejects) each request before payout.           |
| Withdrawal Automation      | On approval, ETH is auto-transferred to the lawyer’s address.               |
| Contract Termination       | Client can terminate the retainer anytime and get refunded unused funds.    |
| View Requests              | Anyone can view request count or details of any request by index.           |

---

## 🏗️ Contract Structure

### State Variables
- `client`: Client's address
- `lawyer`: Lawyer's address
- `retainerAmount`: Agreed upfront amount
- `depositedAmount`: Amount deposited so far
- `hourlyRate`: Lawyer's rate per hour
- `requests`: Array of payment requests
- `isTerminated`: Tracks if contract is terminated

### Modifiers
- `onlyClient`: Restricts access to client
- `onlyLawyer`: Restricts access to lawyer
- `notTerminated`: Ensures contract is still active

### Main Functions

| Function                         | Access         | Purpose                                         |
|----------------------------------|----------------|-------------------------------------------------|
| `receive()`                      | Client only    | Deposit funds into the contract                 |
| `logWorkAndRequestPayment()`     | Lawyer only    | Log hours and submit payment request            |
| `approveRequest(index)`          | Client only    | Approve a payment request and release funds     |
| `rejectRequest(index)`           | Client only    | Reject a pending payment request                |
| `terminateContract()`            | Client only    | Refund unused funds and terminate the contract  |
| `getRequestCount()`              | Public         | View number of requests                         |
| `getRequest(index)`              | Public         | View details of a specific request              |

---

## 🛡️ License
Licensed under the MIT License.
