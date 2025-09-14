# ADR-0001: Architecture & SOLID Mapping

## Status
Proposed

## Context
We are building a Flutter Web diagram editor with hierarchical drill-down and Mermaid import/export.

## Decision
Adopt a layered architecture with strict boundaries:
- **Model**: immutable entities (`Node`, `Edge`, `DiagramSpace`).
- **Services**: `LayoutService`, `CommandService` (undo/redo), `DiagramRepository` (storage), `Serializer` interfaces.
- **Presentation**: widgets and painters (canvas, nodes, edges).
- **Integration**: Mermaid bridge (JS interop) behind `MermaidParser`/`MermaidSerializer` interfaces.

### SOLID
- **SRP**: Separate responsibilities (model vs layout vs rendering vs commands).
- **OCP**: New commands/layouts/serializers can be added without modifying existing classes.
- **LSP**: Service interfaces with interchangeable implementations (e.g., storage adapters).
- **ISP**: Narrow interfaces (`Serializer`, `Parser`, `Repository`) to avoid fat contracts.
- **DIP**: Presentation depends on abstractions via Riverpod providers.

## Consequences
- Easy to test components in isolation.
- Facilitates future collaboration and plugins.
- Slight overhead in boilerplate and interfaces.
