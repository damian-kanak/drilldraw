# Pull Request

## 📋 Description
<!-- Provide a clear and concise description of what this PR does -->

## 🔗 Related Issue
<!-- Link to the issue this PR addresses -->
- Fixes #(issue_number)
- Related to #(issue_number)

## 🏷️ PR Title Format
<!-- PR title MUST start with the addressed issue number -->
<!-- Example: "#123 feat: add rectangle drawing tool" -->

**⚠️ REQUIRED: All PR titles must begin with the issue number they address**

## 🌿 Branch Naming Policy
<!-- Branch names MUST follow this format -->
<!-- Format: "I-123-short-descriptive-title" -->
<!-- Examples: "I-58-add-issue-templates", "I-103-rectangle-rendering" -->

**⚠️ REQUIRED: Branch names must start with "I-" followed by the issue number they address**

## 📝 Implementation Details
<!-- Describe HOW the changes were implemented -->
<!-- Include relevant technical decisions, approaches, and considerations -->
<!-- Explain any architectural changes or design patterns used -->

## 📝 Type of Change
<!-- Check the relevant option -->
- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] 📚 Documentation update
- [ ] 🧪 Test addition or update
- [ ] 🔧 Refactoring (no functional changes)
- [ ] 🚀 Performance improvement
- [ ] 🎨 UI/UX improvement

## 🏷️ Labels
<!-- Apply appropriate labels based on CONTRIBUTING.md guidelines -->

### Area (choose one):
- [ ] `area-canvas` - Canvas drawing and interaction features
- [ ] `area-node` - Node creation and management functionality
- [ ] `area-edge` - Edge/connection functionality
- [ ] `area-hierarchy` - Hierarchical structure features
- [ ] `area-ui` - User interface components and layout
- [ ] `area-devops` - CI/CD, deployment, and infrastructure
- [ ] `area-docs` - Documentation and guides
- [ ] `area-mermaid` - Mermaid diagram integration

### Kind (choose one):
- [ ] `kind-feature` - New feature or enhancement
- [ ] `kind-bug` - Bug fix or issue resolution
- [ ] `kind-chore` - Maintenance, refactoring, cleanup
- [ ] `kind-spike` - Research, experimentation, proof of concept

### Priority (choose one):
- [ ] `prio-P1` - Critical priority - must fix immediately
- [ ] `prio-P2` - High priority - should fix soon
- [ ] `prio-P3` - Medium priority - nice to have

### Phase (choose one):
- [ ] `phase-PoC` - Proof of Concept phase
- [ ] `phase-MVP` - Minimum Viable Product phase
- [ ] `phase-Beta` - Beta release phase

## 🧪 Testing
<!-- Describe the tests you ran to verify your changes -->

### Test Coverage
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Integration tests added/updated
- [ ] All existing tests pass

### Manual Testing
- [ ] Tested on web (Chrome)
- [ ] Tested on mobile (if applicable)
- [ ] Tested accessibility features
- [ ] Verified keyboard shortcuts work
- [ ] Tested edge cases

### Test Commands
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run analysis
flutter analyze

# Check formatting
dart format --set-exit-if-changed .
```

## 📱 Screenshots/Videos
<!-- If applicable, add screenshots or videos to help explain your changes -->
<!-- For UI changes, before/after screenshots are helpful -->

## 🔄 Breaking Changes
<!-- If this PR introduces breaking changes, describe them here -->
- [ ] This PR introduces breaking changes
- [ ] Migration guide provided
- [ ] Documentation updated

## 📋 Checklist
<!-- Mark completed items with [x] -->

### Code Quality
- [ ] Code follows Dart/Flutter style guidelines
- [ ] Code is self-documenting with clear variable/function names
- [ ] No hardcoded values (use constants from `AppConstants`)
- [ ] Proper error handling implemented
- [ ] No console.log or debug prints left in code

### Performance
- [ ] No performance regressions introduced
- [ ] Used `const` constructors where appropriate
- [ ] Optimized widget rebuilds with proper keys
- [ ] Memory leaks prevented

### Security
- [ ] Input validation implemented
- [ ] No sensitive data exposed
- [ ] Secure coding practices followed

### Documentation
- [ ] Public APIs documented with Dartdoc comments
- [ ] README.md updated (if needed)
- [ ] Code comments explain complex logic
- [ ] Examples provided for new features

### Accessibility
- [ ] Semantic labels added to widgets
- [ ] Keyboard navigation works
- [ ] Screen reader compatibility verified
- [ ] Focus management implemented correctly

## 🚀 Deployment
<!-- Any special deployment considerations -->
- [ ] No special deployment steps required
- [ ] Database migrations needed (if applicable)
- [ ] Environment variables updated (if applicable)
- [ ] CI/CD pipeline updated (if applicable)

## 📚 Additional Notes
<!-- Add any additional information that reviewers should know -->
<!-- Include any TODOs or future improvements -->

## 🔍 Review Guidelines
<!-- For reviewers -->
- [ ] Verify all tests pass
- [ ] Check code follows style guidelines
- [ ] Ensure proper error handling
- [ ] Verify accessibility features work
- [ ] Test on multiple platforms (if applicable)
- [ ] Check for performance implications

---

## 🚨 **IMPORTANT: PR Policy Requirements**

### ✅ **Approval Requirements**
- [ ] **Minimum 2 approvals required** (or owner approval)
- [ ] **No direct pushes to main** when addressing issues
- [ ] All CI checks must pass before merge

### ✅ **Content Requirements**
- [ ] **Issue number in title** (e.g., "#123 feat: add feature")
- [ ] **Implementation details provided** (how changes were made)
- [ ] **Tests included** when applicable
- [ ] **Relevant information** about the changes

### ✅ **Process Requirements**
- [ ] **Branch protection enabled** - no direct pushes to main
- [ ] **All reviewers must approve** before merge
- [ ] **CI pipeline must pass** all checks

### ✅ **Branch Naming Requirements**
- [ ] **Branch name starts with "I-" and issue number** (e.g., "I-123-short-title")
- [ ] **Descriptive but concise** branch name
- [ ] **Follows naming convention**: `I-{number}-{short-description}`

**By submitting this PR, I confirm:**
- [ ] I have read and followed the [Contributing Guidelines](CONTRIBUTING.md)
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] **This PR addresses a specific issue and includes the issue number in the title**
- [ ] **My branch name follows the convention: "I-{number}-{short-description}"**
- [ ] **I understand this PR requires approval from 2 reviewers or the owner**
- [ ] **I understand no direct pushes to main are allowed when addressing issues**
