# SHA-256 Hardware Implementation – VLSI III Project

## 📚 Overview

This project involves the design and implementation of the Secure Hash Algorithm 256 (SHA-256) using VLSI hardware principles. The implementation includes architectural decisions, finite state machine (FSM) control, message scheduling, and SHA computation stages, realized in a hardware simulation environment.

---

## 🧑‍💻 Team

**Group – University of Patras**  
- Myriam Mais
- Theodosios Bourtsouklis

---

## 🗓️ Date

**25 February 2025**

---

## 🔐 SHA-256 Functional Stages

### 1. Padding
- Input message `M` of length `l` is padded to form a message of length `k × 512` bits.
- Follows the formula: `l + 1 + n + 64 = k × 512`, where:
  - `1` is the single '1' bit
  - `n` is the number of padding '0' bits
  - `64` is the binary representation of `l`

### 2. Parsing
- The padded message is divided into `k` 512-bit blocks: `Mi`.

### 3. Message Schedule
- Each block `Mi` produces:
  - 16 initial 32-bit words
  - 64 32-bit words `Wt` via expansion functions

### 4. SHA-256 Computation
- Operates on 64 rounds using initialized hash values and the `Wt` words.
- Uses functions like:
  - `Ch(x,y,z) = (x AND y) XOR (¬x AND z)`
  - `Maj(x,y,z) = (x AND y) XOR (x AND z) XOR (y AND z)`
  - Bitwise rotation and shift functions `Σ0`, `Σ1`, `σ0`, `σ1`

---

## 🧱 Architecture

### Finite State Machine (FSM)
| State | Description |
|-------|-------------|
| A     | Idle – waits for `start` or `continue` |
| B     | Processing input words `Wt`, `0 ≤ t ≤ 15` |
| C     | Continued processing for `16 ≤ t ≤ 63` |
| D     | Hash result is ready – returns to idle |

### Message Scheduler
- Chooses between direct input `Wt` or processed value based on control signal.

### SHA-256 Compute
- Registers `a` through `h` initialized in various modes (previous hash, constants, or internal values).
- Final hash calculated by adding processed values to the initial hash.
## 🧪 Example Input & Output

**Input:**  
`theodosissaaefergtrgrtyhtyhytht5t45y56y4rrrrrrr...`

**Output (SHA-256):**  
