/speckit.specify Create a baseline behavior and compatibility specification for modernizing the controller layer of an existing enterprise web application.

This specification will serve as the behavioral contract for a later migration from the current Grails 3 and Java 7 application to a supported Grails 7 and Java 17 environment. Do not design the technical implementation, propose code changes, select dependencies, or describe the migration sequence in this specification.

Primary objective:

Preserve all approved externally observable controller behavior while enabling the application to move away from its unsupported legacy platform. The migration must not unintentionally change URLs, request handling, authorization, validation, response structures, views, redirects, session behavior, or business outcomes.

Use the existing repository as evidence. Examine the current controllers, URL mappings, controller tests, functional tests, security configuration, interceptors or filters, views, API documentation, and relevant service interfaces. Do not modify application code.

Clearly distinguish between:

* Behavior verified by an existing automated test
* Behavior explicitly documented
* Behavior inferred from source code
* Behavior that remains ambiguous and requires stakeholder clarification

Do not invent missing behavior. Mark material uncertainties with `[NEEDS CLARIFICATION: specific question]`.

Users and affected parties include:

* Existing browser users
* Existing API consumers
* Internal systems calling controller endpoints
* Administrators and authenticated users
* Operations and support teams
* Developers responsible for maintaining the application

The specification must cover every in-scope controller and publicly reachable action.

For each controller action, capture the externally observable contract:

* Controller and action name
* Public URL or URL pattern
* Supported HTTP methods
* Path, query, form, multipart, and body parameters
* Required and optional parameters
* Parameter validation and conversion behavior
* Accepted request content types
* Produced response content types
* Successful response status
* Response body or view
* JSON or XML field structure when applicable
* View name and required model attributes
* Redirect or forward destination
* Flash, cookie, and session effects
* Authentication requirement
* Authorization rule
* CSRF expectations
* Not-found behavior
* Validation-failure behavior
* Unauthorized and forbidden behavior
* Unexpected-error behavior
* File-upload behavior and limits
* Content-negotiation behavior
* Asynchronous behavior, when applicable
* Relevant side effects initiated through application services

Define the following compatibility requirements:

1. Existing public URLs and URL parameters must remain valid unless a change is explicitly approved.

2. Each action must continue accepting only its approved HTTP methods.

3. Existing authentication and authorization boundaries must be preserved. The migration must not expose previously protected actions or data.

4. Successful requests must preserve their approved status codes, response content types, response fields, redirects, views, and business outcomes.

5. Invalid requests must preserve their approved validation messages, error categories, status codes, and response formats.

6. Existing JSON and XML consumers must not receive unapproved field removals, field additions, type changes, date-format changes, enum-format changes, null-handling changes, or association-expansion changes.

7. Existing HTML controller actions must preserve their view selection, model keys, redirect behavior, flash messages, and form-submission outcomes.

8. Session, cookie, locale, and request-state behavior must remain unchanged unless an intentional change is documented and approved.

9. File-upload endpoints must continue enforcing approved file-size, request-size, file-count, content-type, and empty-file rules.

10. Controller actions must produce one response path. Redirecting, forwarding, rendering, or returning an error must not allow unintended processing to continue.

11. Controller migration must not introduce new application features, change database schemas, redesign business workflows, or alter domain rules.

12. Business outcomes currently delegated to application services must remain equivalent. This specification should describe the outcome without prescribing controller or service implementation structure.

13. The migration must not create security regressions involving mass assignment, parameter manipulation, cross-site request forgery, unauthorized object access, file uploads, or information disclosure through error responses.

14. Existing operationally important logging, request correlation, audit events, and error visibility must remain available.

Include acceptance scenarios for at least:

* Successful HTML request
* Successful JSON request
* Valid create or update request
* Validation failure
* Missing required parameter
* Invalid parameter type
* Resource not found
* Unauthenticated request
* Authenticated but unauthorized request
* Unsupported HTTP method
* Unsupported content type
* Redirect flow
* Session-dependent flow
* File upload, if supported
* Unexpected application error
* Concurrent or duplicate submission where relevant

Identify edge cases including:

* Empty request bodies
* Null and blank values
* Unknown JSON fields
* Very large numeric identifiers
* Duplicate parameters
* Malformed JSON or XML
* Date and time values with or without time zones
* Enum values with unexpected capitalization
* URLs or identifiers containing periods
* Empty uploaded files
* Multipart requests containing many parts
* Lazy-loaded or recursive object relationships in responses
* Expired sessions
* Requests with conflicting content-type and accept headers

The baseline must also identify:

* Controllers with no automated coverage
* Public actions with unclear consumers
* Dynamically generated or convention-based routes
* Actions dependent on legacy plugins
* Actions directly accessing persistence
* Actions directly binding request data to persistent objects
* Actions directly serializing persistent objects
* Actions containing substantial business logic
* Actions dependent on custom servlet behavior
* Actions dependent on filters, interceptors, layouts, or security plugins

Success criteria:

* Every in-scope public controller action is inventoried.
* Every action has an identified route, HTTP method, security rule, input contract, and output contract.
* Every critical user workflow has executable acceptance coverage or is explicitly identified as a coverage gap.
* All migration-critical ambiguities are resolved before implementation planning.
* The target implementation can be compared against the baseline using repeatable contract tests.
* There are zero unapproved differences in public routes, authorization decisions, successful responses, validation responses, redirects, views, session effects, and API schemas.
* No new security exposure is introduced.
* Stakeholders can review the specification without needing to understand Grails, Groovy, Java, Spring, or Gradle.

Out of scope:

* Selecting framework, library, plugin, or build-tool versions
* Describing package or import replacements
* Writing controller code
* Designing build scripts
* Database-schema changes
* Domain-model redesign
* User-interface redesign
* New product functionality
* Performance optimization unrelated to preserving current service levels
* Refactoring that is not required to achieve behavioral compatibility

Produce a bounded, testable baseline specification. Organize the requirements by user workflow and externally observable behavior rather than by source-code file. Include assumptions, dependencies, risks, edge cases, and measurable success criteria.
