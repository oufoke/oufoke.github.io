---
title: "Why your data projects fail at production"
date: 2026-05-15
type: posts
draft: false
language: fr
hero: "images/sections/posts/Article_projets.png"
tags: ["DataOps", "Governance", "Data Product Management", "Change Management"]
categories: ["Thought Leadership"]
summary: "It's almost never the code. It's the organization around the code."
---

I've worked on a data project that had everything it needed to succeed.

A budget. A motivated team. IT involvement. Available data. A real business need.

And yet, deliverables weren't meeting the expectations of the interface contract between IT and business teams. Tensions rose. Someone always ended up taking the blame.

This is a pattern I've seen confirmed through expert testimonials at webinars and conferences, across different configurations, different organizations. And after years of working at the heart of complex data projects, I came to understand why.

**It's almost never the code, nor the programs that are the problem. It's the organization around the code.**

---

## The perfect project on paper

The team had a project manager, a manager, an intern, and a few technical profiles. Individual skills were there. So was the goodwill.

But no one on that team had solid training in **DataOps**. No one really knew how to do **data-specific product management**. **Data quality governance** was treated as IT's problem, not the project team's. And **change management**? We'd deal with that at delivery.

Result: deliverables could be technically correct but unusable in production. KPI definitions could shift between sprints with no documentation. IT received data that was hard to industrialize. Business teams questioned delivery timelines, IT questioned the quality of specifications — a mutual distrust set in, without anyone being individually responsible.

And when pressure mounted, someone had to take the blame.

---

## The 4 competencies no one thought to include

### 1. DataOps — production is not the finish line, it's the starting point

In many data teams, going to production is treated as the finish line. You ship, you move on.

In reality, it's when everything starts. A data pipeline in production must be **observable, maintainable, reproducible**. It must survive the absence of its creator. It must be modifiable without breaking everything.

Without someone who masters DataOps practices — versioning, CI/CD, separate environments, automated testing — every update becomes a risky operation. Every incident becomes a crisis.

**What it would have changed:** a test environment separate from production, versioned pipelines, blocking Quality Gates before every deployment. Zero delivery without automatic validation.

### 2. Data Product Management — knowing what you're building before you build it

A data project without a data product manager is a team building what developers understood of the business need — not what the business actually needs.

The Data PM isn't a project manager with a spreadsheet. It's someone who can translate a business need into a technical specification, define success metrics **before** delivery, prioritize a backlog by real impact, and distinguish what must be shipped fast from what must be done well.

Without this competency, teams ship features no one uses. They spend months on dashboards executives never open.

**What it would have changed:** a discovery phase with real users, a backlog prioritized by usage data, metrics defined before each sprint — not after.

### 3. Data Governance & Quality — the invisible problem until it explodes publicly

Data quality is the topic no one discusses until a wrong number lands in an executive committee — or worse, in a public report.

In the most common configurations, every team has its own definition of KPIs. Data sources change without notifying consumers. Anomalies accumulate silently until an end user detects them — too late, too visibly.

Industry studies on data governance show that the same indicator can have up to three different definitions depending on which team you ask. Not out of bad intent. Out of absent formal process.

**What it would have changed:** a maintained data dictionary, automatic Quality Gates blocking any delivery with detected anomalies, an identified data owner for each critical indicator.

### 4. Change Management — users don't adapt spontaneously

This is the most underestimated competency of all.

A data tool can be technically perfect and be a complete failure if users don't understand why it replaces their old process, how it works, and what they gain from it.

Resistance to change in data projects isn't bad will. It's a normal response to a tool imposed without explanation or involvement.

**What it would have changed:** identify ambassadors before delivery, run test sessions with real users, document concrete use cases, plan a transition phase — not a brutal switch.

---

## What I put in place afterward

After training on these topics, I applied a different approach on subsequent projects.

**Docs-as-Code**: all business rule documentation versioned like code, in a shared repository, with a traceable change history. No more rules changing without leaving a trace.

**Automatic Quality Gates**: no data reaches production without automatic validation of quality thresholds defined upfront with business teams. If an indicator falls outside its normal range, the pipeline stops and alerts.

**Iterative MVP**: we don't ship everything at once. We identify the 20% of features covering 80% of needs, ship them, measure, adjust. Every sprint delivers something usable — not a promise of future delivery.

**Ambassadors identified**: before the first delivery, we identify the most active and influential users. They test first. They surface problems. They become internal relays.

Delivery problems decreased. Not because the code was better. Because the organization around the code had changed.

---

## The checklist before your next production release

Before starting your next data project, ask yourself:

- **DataOps**: Do you have a test environment separate from production? Are your pipelines versioned? Do you have automated tests?
- **Data PM**: Have you defined success metrics before starting to code? Do you know who your priority users are?
- **Governance**: Do you have a data dictionary? Who is responsible for each critical indicator? Are your Quality Gates automatic or manual?
- **Change Management**: Have you identified your ambassadors? Were end users involved in defining the need?

If you answer no to more than half of these — your project isn't behind on code. It's behind on organization.

---

*Oumar Fodé KEBE — Mathematical Data Engineer, Senior Data Product Manager.*  
*[oufoke.github.io/en/](https://oufoke.github.io/en/)*
