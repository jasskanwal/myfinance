# myFinance

A SwiftUI personal finance app built for iOS. I built this to practice clean architecture — MVVM + Coordinator pattern with Swinject for dependency injection.

---

## Architecture

MVVM + Coordinator with Swinject wiring everything at startup.

- **Views** — purely SwiftUI, no business logic
- **ViewModels** — own state, compute derived values, call services
- **Services** — protocol-backed, handle data fetching and transformation
- **Coordinators** — own navigation, wire ViewModels together

---

## Project Structure

### App
- `myFinanceApp` — entry point, boots the coordinator tree via `AppContainer`
- `AppCoordinator` — root coordinator, hands off to `TransactionsCoordinator`

### Core
- `NetworkService` — reads `.json` files from the app bundle, easy to swap for a real HTTP client
- `CurrencyFormatter` — `NumberFormatter` wrapper with `en_US` locale
- `AppColors`, `AppFonts`, `AppImages` — design system tokens, no raw literals in view files

### Transactions Feature
- `TransactionService` — fetches and unwraps the transaction list
- `TransactionsView` / `TransactionsViewModel` — list screen, loads transactions, computes totals and balance
- `TransactionDetailView` / `TransactionDetailViewModel` — detail sheet, formats rows and notice text

---

## Navigation

`NavigationStack` with a typed `NavigationPath`. Each `TransactionRoute` case carries a pre-built ViewModel. The coordinator owns the path and injects a `navigate` closure into the ViewModel, keeping the ViewModel unaware of navigation entirely.

---

## Data

Reads from `transaction-list.json` bundled in the app. No live API calls yet.

---

## Dependencies

- [Swinject](https://github.com/Swinject/Swinject) — dependency injection

---

## Pending

- **DI container tests** — tests for Swinject registrations and scopes not written yet
- **UI tests** — accessibility identifiers are in place, flow tests not written yet
- **Live network** — no real API connected, reads from bundle
- **Pull-to-refresh** — transactions load once on launch, no refresh
- **Localization** — all strings are hardcoded English
