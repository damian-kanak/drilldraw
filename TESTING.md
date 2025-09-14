# TESTING

## Strategy (Testing Pyramid)
- **Unit tests**: Pure logic (layout math, command stack, serializers).
- **Widget/Golden tests**: Rendering of nodes/edges, badges, breadcrumbs.
- **Integration/E2E**: Canvas flows (create, connect, drill-down, export).

## Tools
- `flutter_test`, golden toolkit with image diff tolerance
- Coverage target: **75% overall**, **90% critical paths**

## Performance
- Benchmarks for canvas interactions; target 60 fps with 500 nodes.

## Accessibility
- Keyboard nav and semantics; automated checks where possible.

## CI
- See `.github/workflows/flutter-ci.yml`
