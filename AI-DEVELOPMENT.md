# AI Development Disclosure

This document describes the role of AI tools in the development of this
project.

The use of AI tools is disclosed for transparency and does not, by itself,
change the license of the project. Third-party components and dependencies
remain subject to their respective licenses and terms.

---

## Development Classification

This project uses one of the following development classifications.

### Human-Originated

The initial design and implementation of the project were created by the
project author without substantial AI-generated implementation.

AI tools may subsequently have been used for assistance with development,
such as debugging, refactoring, documentation, testing, code review, or
implementation of new features.

The project author remains responsible for the project's design, technical
direction, integration, review, testing, and final released version.

---

### AI-Assisted

The project was initially originated and implemented by the project author,
but AI coding tools were subsequently used substantially during development.

AI tools may have contributed to code generation, implementation,
debugging, refactoring, documentation, testing assistance, and other
development tasks.

The project author remains responsible for the project's overall design,
requirements, technical direction, evaluation, integration, review, testing,
and final released version.

AI-generated or AI-assisted code may therefore constitute a substantial
portion of the current implementation.

---

### AI-Developed

The project was developed substantially through the use of AI coding tools.

AI tools were used extensively for source-code generation, implementation,
debugging, refactoring, documentation, testing assistance, and other
development activities.

The project author provided the project's purpose, requirements, direction,
evaluation, and final decisions regarding the released version.

This classification describes the development process and does not assert
that an AI system is a legal author or copyright holder of the project.

The project is distributed under the license stated in this repository to
the extent that the project author has the rights necessary to grant that
license.

---

## AI Tools

The specific AI tools used during development may be listed below.

* OpenAI Codex
* Other AI coding or development tools, where applicable

The list is informational and may not represent every AI-assisted operation
performed during development.

---

## Third-Party Components

AI-generated code does not automatically replace or override the licenses of
third-party software.

Third-party libraries, source code, assets, models, datasets, APIs, and other
components remain subject to their respective licenses and terms.

Users and redistributors should review the applicable licenses of third-party
components when redistributing or incorporating this project into other
software.

---

## AI Output and Similarity

AI coding tools may produce output that is similar or identical to output
generated for other users or that resembles existing code or other material.

The project author does not claim that every individual piece of
AI-generated output is necessarily unique.

Users should perform appropriate license and dependency review when
redistributing this project or incorporating its contents into another
software project.

---

## Responsibility

The use of AI tools does not transfer responsibility for the released
software to the AI tool provider.

The project author is responsible for the decisions made regarding the
project's requirements, integration, testing, release, and licensing, to the
extent applicable under law.

---

## Project-Specific Classification

**Development classification:** `AI-Assisted`

**Primary AI development tool:** OpenAI Codex

**Additional notes:**

* **Initial implementation.** The author's original version of this tool is a shell
  script written before this repository existed. It was committed unchanged as
  `clean-icon-cache.sh` in the first code commit (`54e26a0`), and it is the direct
  ancestor of every version that followed.

* **AI-assisted work.** Everything after that point was produced with OpenAI Codex
  under the author's direction and review: the JXA dialog version, `build-app.sh`, the
  multilingual READMEs, the safety hardening (confirmation prompt, dry run, error
  handling), the commit-signing and dual-remote setup, and the workflow documentation.

* **Public releases.** The public GitHub repository receives `main` only, at explicit
  release points. The complete development history is kept in a private archive, so the
  public repository may deliberately lag behind.

* **Classification last reviewed:** 2026-09-15.
