# IZLO – Projekt 2: SMT Solvery

Riešenie 2. projektu z predmetu IZLO (Logika a grafy) na FIT VUT.

## Obsah úlohy
- **SMT-LIB 2** – tvorba logickej formuly pre SMT solver (Satisfiability Modulo Theories).
- **Analýza kódu** – reverzné inžinierstvo funkcie v C-like jazyku.
- **SSA Forma** – prevod imperatívneho kódu do *Single-Static Assignment* formy (premenné $x_0, x_1, \dots$).
- **Optimalizácia** – hľadanie vstupných hodnôt $(D, E)$, ktoré minimalizujú súčet $D+E$ a zároveň splnia podmienky funkcie.

Projekt bol vytvorený výlučne na vzdelávacie účely.

## Technológie
- **Jazyk:** SMT-LIB 2.0 (Lisp-like syntax)
- **Teória:** Integer Arithmetic (Int)
- **Nástroj:** cvc5 / Z3 solver

## Hodnotenie
- Získané body: **10 / 10**

## Spustenie
Na overenie riešenia je potrebný SMT solver (odporúčaný `cvc5`).

```bash
# Spustenie solvera nad súborom
cvc5 project2.smt2

# Alternatívne pomocou Z3
z3 project2.smt2
