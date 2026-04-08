# Bakery sales & packing

## Background
The bakery used to price orders as **quantity × single-item price** (e.g. 10 hot cross buns → 10× one bun).
They now sell **predefined packs** only and charge **per pack**.
Example: vegemite scrolls in packs of 3 and 5; an order of **8** is **one pack of 3** plus **one pack of 5**.

### Catalogue
| Name             | Code | Packs / prices   |
| ---------------- | ---- | ---------------- |
| Vegemite Scroll  | VS5  | 3 @ $6.99, 5 @ $8.99 |
| Blueberry Muffin | MB11 | 2 @ $9.95, 5 @ $16.95, 8 @ $24.95 |
| Croissant        | CF   | 3 @ $5.95, 5 @ $9.95, 9 @ $16.99 |

## Task

Given a customer order, compute the **total cost** and **pack breakdown** per product.
**Constraint:** Use the **minimum number of packs** for each line item (to save shipping space).

## Input
One line per product: **quantity**, then **product code**.

Example:
```
10 VS5
14 MB11
13 CF
```

## Output

Tests should demonstrate output in this spirit (format may vary per your implementation):

```
10 VS5 $17.98
    2 x 5 $8.99
14 MB11 $54.8
    1 x 8 $24.95
    3 x 2 $9.95
13 CF $25.85
    2 x 5 $9.95
    1 x 3 $5.95
```

---

## Advice

- Use any language you’re comfortable with.
- Input/output formatting is flexible—pick something reasonable.
- Include **at least one test**.
- Write code you’d be happy to ship to production.
- If anything is ambiguous, ask—or state an assumption and proceed.

---

## Evaluation criteria

### Is the code functional?
- Clear setup / install instructions?
- Meets the spec and edge cases?
- Sensible behaviour beyond the happy path?

### Is the code readable?
- Clear names for variables and methods?
- Reasonably small methods (e.g. &lt; ~20 lines)?
- Low complexity per unit of behaviour?

### Is the code tested?
- Unit tests for major pieces?
- End-to-end or integration coverage where it helps?

### Is the design sound?
- Object-oriented (or justified alternative)?
- Single Responsibility Principle?
- Law of Demeter where appropriate?
