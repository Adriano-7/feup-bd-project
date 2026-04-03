# Futsal Championship Database

> **Project**
> <br />
> Course Unit: [Bases de Dados](https://sigarra.up.pt/feup/pt/ucurr_geral.ficha_uc_view?pv_ocorrencia_id=501676 "Bases de Dados"), 2nd year
> <br />
> Course: Degree in Informatics and Computing Engineering (LEIC)
> <br />
> Faculty: **FEUP** (Faculty of Engineering of the University of Porto)
> <br />
> Project Report: [Report](https://github.com/Adriano-7/feup-bd-project/blob/main/Relat%C3%B3rio%20BD%20-%20Corrigido.pdf) 
> <br />
> Project evaluation: **17**/20

---

## Project Goals

The objective of this project was to implement a relational database to manage the Portuguese National Futsal Championship. The system handles both the regular season (group stage) and the Playoffs, storing detailed information about teams, players, referees, matches, and individual goals. 

## Technical Approach

### 1. Conceptual & Relational Schema
The database was modeled to accurately represent the real-world entities of a sports championship. The main entities include:
* **Pessoa (Person)**: Generalized table for `Treinador` (Coach), `Arbitro` (Referee), and `Jogador` (Player).
* **Equipa (Team)**: Stores team details and aggregated statistics (points, goals scored/conceded, wins, ties).
* **Jogo (Match) & GoloMarcado (Scored Goal)**: Tracks match results and the exact minute/player of each goal.
* **Jornada & Playoff**: Manages the temporal organization of the regular season and the knockout stages.

### 2. Normalization & Functional Dependencies
The schema was analyzed for functional dependencies to ensure it met **Boyce-Codd Normal Form (BCNF)** and **3rd Normal Form (3NF)**.

### 3. Business Logic & Triggers
To maintain data integrity and automatically update standings without manual intervention, we implemented several SQLite triggers:
* **Trigger 1 & 4 (Update Standings)**: Automatically updates a team's total points, goals scored, goals conceded, wins, and ties whenever a `Jogo` (Match) is inserted or updated.
* **Trigger 2 (Goal Synchronization)**: Automatically increments the match's score (`golosMarcadosVisitante` or `golosMarcadosVisitado`) whenever a new `GoloMarcado` (Goal) is registered to a specific player.
* **Trigger 3 (Jersey Number Constraint)**: Prevents assigning an already taken jersey number (`numeroCamisola`) to a new player in the same team.

## Running the code

**Prerequisites:** You need [SQLite3](https://sqlite.org/index.html) installed on your machine.

**1. Create the database and tables:**
```bash
sqlite3 futsal.db < criar.sql
```

*(Note: To populate the database, you can import the provided CSV files in the `data/` folder directly into SQLite).*

**2. Test the Triggers:**
```bash
sqlite3 futsal.db < Gatilhos/gatilho1_verifica.sql
```

**3. Run the analytical queries:**
```bash
sqlite3 futsal.db < Queries/int1.sql
```

## Tech stack

- **Database**: SQLite3
- **Data Generation**: C++
- **Design & Modeling**: UML, Relational Algebra

## Team

- Adriano Machado (up202105352)
- José Pedro Evans (up202108818)
